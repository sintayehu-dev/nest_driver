class LocationState {
  const LocationState({
    this.isAvailable = false,
    this.isLoading = false,
    this.errorMessage,
    this.locations = const [],
  });

  final bool isAvailable;
  final bool isLoading;
  final String? errorMessage;
  final List<String> locations;

  LocationState copyWith({
    bool? isAvailable,
    bool? isLoading,
    String? errorMessage,
    List<String>? locations,
  }) {
    return LocationState(
      isAvailable: isAvailable ?? this.isAvailable,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      locations: locations ?? this.locations,
    );
  }
}

