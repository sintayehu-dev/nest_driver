import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';

/// Service for monitoring network connectivity changes
@lazySingleton
class NetworkMonitorService {
  NetworkMonitorService() {
    _init();
  }

  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<NetworkState>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NetworkType _currentType = NetworkType.none;
  bool _isConnected = false;

  /// Stream of network state changes
  Stream<NetworkState> get networkStream => _controller.stream;

  /// Current network type
  NetworkType get currentType => _currentType;

  /// Whether device is connected to any network
  bool get isConnected => _isConnected;

  void _init() {
    _startMonitoring();
  }

  Future<void> _startMonitoring() async {
    try {
      // Get initial connectivity
      final results = await _connectivity.checkConnectivity();
      _handleConnectivityChange(results);

      // Listen to connectivity changes
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen((results) {
        _handleConnectivityChange(results);
      });

      log('📡 Network Monitor: Started monitoring');
    } catch (e) {
      log('❌ Network Monitor: Failed to start monitoring: $e');
    }
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    try {
      final networkType = _determineNetworkType(results);
      final isConnected = networkType != NetworkType.none;

      if (networkType != _currentType || isConnected != _isConnected) {
        _currentType = networkType;
        _isConnected = isConnected;

        log('📡 Network Monitor: Network changed to $networkType (connected: $isConnected)');

        _controller.add(NetworkState(
          type: networkType,
          isConnected: isConnected,
        ));
      }
    } catch (e) {
      log('❌ Network Monitor: Error handling connectivity change: $e');
    }
  }

  NetworkType _determineNetworkType(List<ConnectivityResult> results) {
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      return NetworkType.none;
    }

    // WiFi has priority
    if (results.contains(ConnectivityResult.wifi)) {
      return NetworkType.wifi;
    }

    // Mobile data (cellular)
    if (results.contains(ConnectivityResult.mobile)) {
      return NetworkType.mobile;
    }

    // Ethernet (treat as WiFi for our purposes)
    if (results.contains(ConnectivityResult.ethernet)) {
      return NetworkType.wifi;
    }

    // VPN (treat as current underlying connection)
    if (results.contains(ConnectivityResult.vpn)) {
      // If VPN is the only result, assume mobile
      return NetworkType.mobile;
    }

    // Bluetooth or other (treat as poor)
    if (results.contains(ConnectivityResult.bluetooth) ||
        results.contains(ConnectivityResult.other)) {
      return NetworkType.poor;
    }

    return NetworkType.none;
  }

  /// Mark network as poor quality (can be called externally based on connection failures)
  void markAsPoor() {
    if (_currentType != NetworkType.poor && _currentType != NetworkType.none) {
      log('📡 Network Monitor: Marking network as POOR due to connection issues');
      _currentType = NetworkType.poor;
      _controller.add(NetworkState(
        type: NetworkType.poor,
        isConnected: _isConnected,
      ));
    }
  }

  /// Manually refresh network state
  Future<void> refresh() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _handleConnectivityChange(results);
    } catch (e) {
      log('❌ Network Monitor: Failed to refresh: $e');
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _controller.close();
  }
}

/// Network state data class
class NetworkState {
  const NetworkState({
    required this.type,
    required this.isConnected,
  });

  final NetworkType type;
  final bool isConnected;

  @override
  String toString() => 'NetworkState(type: $type, connected: $isConnected)';
}
