import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/location_service.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_location_update.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_status.dart';
import 'package:nest_driver/features/driver/location/domain/repositories/driver_location_repository.dart';

import 'location_event.dart';
import 'location_state.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(
    this._locationService,
    this._locationRepository,
  ) : super(const LocationState()) {
    on<LocationAvailabilityToggled>(_onAvailabilityToggled);
    on<LocationStreamUpdated>(_onStreamUpdated);
    on<LocationStreamError>(_onStreamError);
    on<LocationBackendAck>(_onBackendAck);
    on<LocationBackendError>(_onBackendError);
    on<LocationBackendDisconnected>(_onBackendDisconnected);
  }

  final LocationService _locationService;
  final DriverLocationRepository _locationRepository;
  StreamSubscription<Position>? _positionSub;
  StreamSubscription? _backendAckSub;
  StreamController<DriverLocationUpdate>? _updateController;
  DateTime? _lastUpdate;
  DateTime? _startTime;
  Timer? _fallbackTimer;
  bool _isFallbackInProgress = false;
  String? _currentBookingId;
  DriverStatus _currentStatus = DriverStatus.available;

  static const _maxInterval = Duration(milliseconds: 2500);

  Future<void> _onAvailabilityToggled(
    LocationAvailabilityToggled event,
    Emitter<LocationState> emit,
  ) async {
    dev.log('Availability toggled: ${event.isAvailable}');
    if (!event.isAvailable) {
      await _stopStream();
      await _stopBackendStream();
      emit(state.copyWith(
        isAvailable: false,
        isLoading: false,
        errorMessage: null,
        locations: const [],
        isBackendConnected: false,
        backendError: null,
      ));
      return;
    }

    emit(state.copyWith(
      isAvailable: true,
      isLoading: true,
      errorMessage: null,
      backendError: null,
    ));

    _startTime = DateTime.now();
    _currentStatus = DriverStatus.available;
    final ok = await _locationService.ensurePermission(event.context);
    if (!ok) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Location permission is required.',
      ));
      return;
    }

    await _startStream();
    await _startBackendStream(emit);
    dev.log(
      'Availability ON → backendConnected=${state.isBackendConnected}, socket updates active=${_updateController != null && !_updateController!.isClosed}',
    );
  }

  void _onStreamUpdated(
    LocationStreamUpdated event,
    Emitter<LocationState> emit,
  ) {
    final updated = List<String>.from(state.locations)..add(event.locationText);
    // If we hit 10 entries, reset and start fresh with the latest.
    final trimmed = updated.length > 10 ? [event.locationText] : updated;
    emit(state.copyWith(
      isLoading: false,
      errorMessage: null,
      locations: trimmed,
    ));
  }

  void _onStreamError(
    LocationStreamError event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(
      isLoading: false,
      errorMessage: event.message,
    ));
  }

  Future<void> _startStream() async {
    await _positionSub?.cancel();
    _fallbackTimer?.cancel();
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    // Emit one reading immediately so UI leaves "loading" sooner.
    final initialStart = DateTime.now();
    try {
      final initial = await _locationService.getCurrentPosition();
      final initialElapsed = DateTime.now().difference(initialStart).inMilliseconds;
      final sinceToggle = _startTime == null
          ? null
          : DateTime.now().difference(_startTime!).inMilliseconds;
      dev.log(
        'Initial location fetched in ${initialElapsed}ms'
        '${sinceToggle != null ? ', since toggle=${sinceToggle}ms' : ''}',
      );
      _handlePosition(initial, force: true);
    } catch (e) {
      dev.log('Initial location fetch failed: $e');
      add(LocationStreamError('Unable to get initial location.'));
    }

    _positionSub = Geolocator.getPositionStream(locationSettings: settings).listen(
      (pos) => _handlePosition(pos),
      onError: (e) {
        dev.log('Location stream error: $e');
        add(LocationStreamError('Unable to get location.'));
      },
    );

    _fallbackTimer = Timer.periodic(_maxInterval, (_) => _checkStaleness());
  }

  void _handlePosition(Position pos, {bool force = false}) {
    final now = DateTime.now();
    final sinceLast = _lastUpdate == null ? null : now.difference(_lastUpdate!).inMilliseconds;
    final sourceLag = now.difference(pos.timestamp).inMilliseconds;
    final sinceToggle = _startTime == null ? null : now.difference(_startTime!).inMilliseconds;
    if (!force &&
        _lastUpdate != null &&
        now.difference(_lastUpdate!).inMilliseconds < 1000) {
      return;
    }
    _lastUpdate = now;
    final loc =
        '${pos.latitude.toStringAsFixed(5)}, ${pos.longitude.toStringAsFixed(5)}';
    dev.log(
      'Location streamed: $loc'
      '${sinceLast != null ? ', interval=${sinceLast}ms' : ''}'
      ', sourceLag=${sourceLag}ms'
      '${sinceToggle != null ? ', since toggle=${sinceToggle}ms' : ''}',
    );
    add(LocationStreamUpdated(loc));

    // Send to backend if streaming is active and availability is on
    if (state.isAvailable && 
        _updateController != null && 
        !_updateController!.isClosed) {
      final update = DriverLocationUpdate(
        bookingId: _currentBookingId,
        lat: pos.latitude,
        lon: pos.longitude,
        speed: pos.speed,
        heading: pos.heading,
        accuracy: pos.accuracy,
        status: _currentStatus,
        timestamp: now,
      );
      _updateController!.add(update);
    }
  }

  Future<void> _stopStream() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    dev.log('Location stream stopped');
  }

  Future<void> _startBackendStream(Emitter<LocationState> emit) async {
    await _stopBackendStream();

    _updateController = StreamController<DriverLocationUpdate>();
    
    _backendAckSub = _locationRepository
        .streamLiveLocation(_updateController!.stream)
        .listen(
      (result) {
        result.fold(
          (error) {
            dev.log('Backend location update failed: $error');
            add(LocationBackendError(error.toString()));
          },
          (ack) {
            dev.log('Backend location ack: success=${ack.success}, timestamp=${ack.timestamp}');
            add(LocationBackendAck(ack.timestamp));
          },
        );
      },
      onError: (error, stackTrace) {
        dev.log('Backend stream error: $error', stackTrace: stackTrace);
        add(LocationBackendError(error.toString()));
      },
    );

    emit(state.copyWith(isBackendConnected: true, backendError: null));
    dev.log('Backend location stream started');
  }

  Future<void> _stopBackendStream() async {
    dev.log('Stopping backend location stream...');
    
    // Cancel the subscription first to stop receiving acks
    await _backendAckSub?.cancel();
    _backendAckSub = null;
    
    // Close the update controller - this will trigger stream cancellation
    // in the datasource and disconnect the WebSocket
    if (_updateController != null && !_updateController!.isClosed) {
      await _updateController!.close();
    }
    _updateController = null;
    
    add(LocationBackendDisconnected());
    dev.log('Backend location stream stopped');
  }

  Future<void> _checkStaleness() async {
    if (_isFallbackInProgress) return;
    final now = DateTime.now();
    if (_lastUpdate == null) return;
    final gap = now.difference(_lastUpdate!);
    if (gap <= _maxInterval) return;

    _isFallbackInProgress = true;
    try {
      dev.log('Fallback location fetch after idle gap ${gap.inMilliseconds}ms');
      final pos = await _locationService.getCurrentPosition();
      _handlePosition(pos, force: true);
    } catch (e) {
      dev.log('Fallback location fetch failed: $e');
    } finally {
      _isFallbackInProgress = false;
    }
  }

  void _onBackendAck(
    LocationBackendAck event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(
      lastBackendAck: event.timestamp,
      updatesSentCount: state.updatesSentCount + 1,
      backendError: null,
    ));
  }

  void _onBackendError(
    LocationBackendError event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(
      backendError: event.message,
      updatesFailedCount: state.updatesFailedCount + 1,
      isBackendConnected: false,
    ));
  }

  void _onBackendDisconnected(
    LocationBackendDisconnected event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(isBackendConnected: false));
  }

  @override
  Future<void> close() {
    _stopStream();
    _stopBackendStream();
    return super.close();
  }
}

