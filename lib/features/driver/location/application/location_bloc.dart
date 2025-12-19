import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/background_location_service.dart';
import 'package:nest_driver/core/services/location_service.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
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
    this._backgroundLocationService,
  ) : super(const LocationState()) {
    on<LocationAvailabilityToggled>(_onAvailabilityToggled);
    on<LocationStreamUpdated>(_onStreamUpdated);
    on<LocationStreamError>(_onStreamError);
    on<LocationBackendAck>(_onBackendAck);
    on<LocationBackendError>(_onBackendError);
    on<LocationBackendDisconnected>(_onBackendDisconnected);
    on<LocationPermissionChecked>(_onPermissionChecked);
    on<LocationAvailabilityRestoreRequested>(_onAvailabilityRestoreRequested);
    on<LocationAvailabilityRestoreAuto>(_onAvailabilityRestoreAuto);

    // Kick off an auto-restore without needing a BuildContext.
    Future.microtask(() => add(LocationAvailabilityRestoreAuto()));
  }

  final LocationService _locationService;
  final DriverLocationRepository _locationRepository;
  final BackgroundLocationService _backgroundLocationService;
  StreamSubscription<Position>? _positionSub;
  StreamSubscription? _backendAckSub;
  StreamController<DriverLocationUpdate>? _updateController;
  DateTime? _lastUpdate;
  Timer? _fallbackTimer;
  bool _isFallbackInProgress = false;
  String? _currentBookingId;
  DriverStatus _currentStatus = DriverStatus.available;

  static const _maxInterval = Duration(milliseconds: 2500);

  /// bloc.restoreAvailability(context);
  Future<void> restoreAvailability(BuildContext context) async {
    final cached = LocalStorage.instance.getDriverAvailability();
    if (cached && !state.isAvailable) {
      add(LocationAvailabilityToggled(true, context));
    }
  }

  // Handles availability toggle events
  Future<void> _onAvailabilityToggled(
    LocationAvailabilityToggled event,
    Emitter<LocationState> emit,
  ) async {
    if (!event.isAvailable) {
      await _stopStream();
      await _stopBackendStream();
      await LocalStorage.instance.setDriverAvailability(false);
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
      isLoading: true,
      errorMessage: null,
      backendError: null,
    ));

    _currentStatus = DriverStatus.available;

    final ok = await _locationService.ensurePermission(event.context);
    if (!ok) {
      await LocalStorage.instance.setDriverAvailability(false);
      emit(state.copyWith(
        isAvailable: false,
        isLoading: false,
        errorMessage: 'Location permission is required.',
      ));
      return;
    }

    emit(state.copyWith(
      isAvailable: true,
      isLoading: false,
    ));

    await _startBackendStream(
      emit,
      onConnected: () async {
        await _startStream();
      },
    );

    await LocalStorage.instance.setDriverAvailability(true);
  }

  // Handles location stream updates
  void _onStreamUpdated(
    LocationStreamUpdated event,
    Emitter<LocationState> emit,
  ) {
    final updated = List<String>.from(state.locations)..add(event.locationText);
    final trimmed = updated.length > 10 ? [event.locationText] : updated;
    emit(state.copyWith(
      isLoading: false,
      errorMessage: null,
      locations: trimmed,
    ));
  }

  // Handles location stream errors
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
    // Do not start GPS updates if driver is unavailable.
    if (!state.isAvailable) return;

    await _positionSub?.cancel();
    _fallbackTimer?.cancel();
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    // Emit one reading immediately so UI leaves "loading" sooner.
    try {
      final initial = await _locationService.getCurrentPosition();
      _handlePosition(initial, force: true);
    } catch (e) {
      add(LocationStreamError('Unable to get initial location.'));
    }

    _positionSub =
        Geolocator.getPositionStream(locationSettings: settings).listen(
      (pos) => _handlePosition(pos),
      onError: (_) => add(LocationStreamError('Unable to get location.')),
    );

    _fallbackTimer = Timer.periodic(_maxInterval, (_) => _checkStaleness());
  }

  void _handlePosition(Position pos, {bool force = false}) {
    // Drop GPS samples when unavailable to avoid UI updates while off.
    if (!state.isAvailable && !force) return;

    final now = DateTime.now();
    if (!force &&
        _lastUpdate != null &&
        now.difference(_lastUpdate!).inMilliseconds < 1000) {
      return;
    }
    _lastUpdate = now;
    final loc =
        '${pos.latitude.toStringAsFixed(5)}, ${pos.longitude.toStringAsFixed(5)}';
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
  }

  Future<void> _startBackendStream(
    Emitter<LocationState> emit, {
    void Function()? onConnected,
  }) async {
    await _stopBackendStream();

    _updateController = StreamController<DriverLocationUpdate>();

    _backendAckSub = _locationRepository
        .streamLiveLocation(
      _updateController!.stream,
      onConnected: onConnected,
    )
        .listen(
      (result) {
        result.fold(
          (error) {
            add(LocationBackendError(error.toString()));
          },
          (ack) {
            add(LocationBackendAck(ack.timestamp));
          },
        );
      },
      onError: (error, stackTrace) {
        add(LocationBackendError(error.toString()));
      },
    );

    emit(state.copyWith(isBackendConnected: true, backendError: null));
  }

  Future<void> _stopBackendStream() async {
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
  }

  Future<void> _checkStaleness() async {
    if (_isFallbackInProgress) return;
    final now = DateTime.now();
    if (_lastUpdate == null) return;
    final gap = now.difference(_lastUpdate!);
    if (gap <= _maxInterval) return;

    _isFallbackInProgress = true;
    try {
      final pos = await _locationService.getCurrentPosition();
      _handlePosition(pos, force: true);
    } catch (e) {
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

  // Handles permission check events from app lifecycle
  Future<void> _onPermissionChecked(
    LocationPermissionChecked event,
    Emitter<LocationState> emit,
  ) async {
    try {
      // Only allow background/location services to spin up when the driver
      // explicitly marked themselves as available.
      final cachedAvailability = LocalStorage.instance.getDriverAvailability();
      if (!cachedAvailability) {
        await _stopStream();
        await _stopBackendStream();
        await _backgroundLocationService.stop();
        emit(state.copyWith(
          isAvailable: false,
          isBackendConnected: false,
          isLoading: false,
        ));
        return;
      }

      final isPermissionGranted =
          await _locationService.isLocationPermissionGranted();

      if (!isPermissionGranted) {
        emit(state.copyWith(
          isAvailable: false,
          isBackendConnected: false,
        ));
        return;
      }

      if (isPermissionGranted && !state.isAvailable) {
        emit(state.copyWith(
          isAvailable: true,
          isLoading: true,
          errorMessage: null,
          backendError: null,
        ));

        _currentStatus = DriverStatus.available;

        // Start background service
        try {
          await _backgroundLocationService.start();
        } catch (e) {
          // Log error but continue
        }

        await _startBackendStream(
          emit,
          onConnected: () async {
            await _startStream();
          },
        );

        await LocalStorage.instance.setDriverAvailability(true);
      }
    } catch (e) {
      // Handle errors silently
    }
  }

  Future<void> _onAvailabilityRestoreRequested(
    LocationAvailabilityRestoreRequested event,
    Emitter<LocationState> emit,
  ) async {
    final cached = LocalStorage.instance.getDriverAvailability();
    if (cached && !state.isAvailable) {
      add(LocationAvailabilityToggled(true, event.context));
    }
  }

  Future<void> _onAvailabilityRestoreAuto(
    LocationAvailabilityRestoreAuto event,
    Emitter<LocationState> emit,
  ) async {
    final cached = LocalStorage.instance.getDriverAvailability();
    if (!cached || state.isAvailable) return;

    final hasPermission = await _locationService.isLocationPermissionGranted();
    if (!hasPermission) {
      await LocalStorage.instance.setDriverAvailability(false);
      return;
    }

    emit(state.copyWith(isAvailable: true, isLoading: false));

    // Start background service
    try {
      await _backgroundLocationService.start();
    } catch (e) {
      // Log error but continue
    }

    await _startBackendStream(
      emit,
      onConnected: () async {
        await _startStream();
      },
    );
  }

  @override
  Future<void> close() {
    _stopStream();
    _stopBackendStream();
    _backgroundLocationService.stop();
    return super.close();
  }
}
