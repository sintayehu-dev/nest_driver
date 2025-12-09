import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nest_driver/core/services/location_service.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(this._locationService) : super(const LocationState()) {
    on<LocationAvailabilityToggled>(_onAvailabilityToggled);
    on<LocationStreamUpdated>(_onStreamUpdated);
    on<LocationStreamError>(_onStreamError);
  }

  final LocationService _locationService;
  StreamSubscription<Position>? _positionSub;
  DateTime? _lastUpdate;
  DateTime? _startTime;
  Timer? _fallbackTimer;
  bool _isFallbackInProgress = false;

  static const _maxInterval = Duration(milliseconds: 2500);

  Future<void> _onAvailabilityToggled(
    LocationAvailabilityToggled event,
    Emitter<LocationState> emit,
  ) async {
    dev.log('Availability toggled: ${event.isAvailable}');
    if (!event.isAvailable) {
      await _stopStream();
      emit(state.copyWith(
        isAvailable: false,
        isLoading: false,
        errorMessage: null,
        locations: const [],
      ));
      return;
    }

    emit(state.copyWith(
      isAvailable: true,
      isLoading: true,
      errorMessage: null,
    ));

    _startTime = DateTime.now();
    final ok = await _locationService.ensurePermission(event.context);
    if (!ok) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Location permission is required.',
      ));
      return;
    }

    await _startStream();
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
  }

  Future<void> _stopStream() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _fallbackTimer?.cancel();
    _fallbackTimer = null;
    dev.log('Location stream stopped');
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

  @override
  Future<void> close() {
    _stopStream();
    return super.close();
  }
}

