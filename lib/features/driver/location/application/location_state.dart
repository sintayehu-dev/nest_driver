class LocationState {
  const LocationState({
    this.isAvailable = false,
    this.isLoading = false,
    this.errorMessage,
    this.locations = const [],
    this.isBackendConnected = false,
    this.lastBackendAck,
    this.backendError,
    this.updatesSentCount = 0,
    this.updatesFailedCount = 0,
  });

  final bool isAvailable;
  final bool isLoading;
  final String? errorMessage;
  final List<String> locations;
  
  /// Whether backend WebSocket is connected and ready.
  final bool isBackendConnected;
  
  /// Last successful backend acknowledgement timestamp.
  final DateTime? lastBackendAck;
  
  /// Last backend error message (if any).
  final String? backendError;
  
  /// Count of successfully sent updates.
  final int updatesSentCount;
  
  /// Count of failed updates.
  final int updatesFailedCount;

  LocationState copyWith({
    bool? isAvailable,
    bool? isLoading,
    String? errorMessage,
    List<String>? locations,
    bool? isBackendConnected,
    DateTime? lastBackendAck,
    String? backendError,
    int? updatesSentCount,
    int? updatesFailedCount,
  }) {
    return LocationState(
      isAvailable: isAvailable ?? this.isAvailable,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      locations: locations ?? this.locations,
      isBackendConnected: isBackendConnected ?? this.isBackendConnected,
      lastBackendAck: lastBackendAck ?? this.lastBackendAck,
      backendError: backendError,
      updatesSentCount: updatesSentCount ?? this.updatesSentCount,
      updatesFailedCount: updatesFailedCount ?? this.updatesFailedCount,
    );
  }
}

