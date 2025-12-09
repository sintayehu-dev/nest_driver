# Design Document

## Overview

The Background Location Streaming feature implements a robust, battery-efficient GPS tracking system for the Nest Driver application. The system continuously collects location data in the background, handles network connectivity issues through local queuing, and optimizes battery usage through adaptive update frequencies. The architecture follows Flutter's platform-specific background service patterns and integrates with the existing clean architecture.

## Architecture

The system follows a layered architecture with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │ Location Status │  │ Permission Flow │  │ Settings UI  │ │
│  │     Widget      │  │     Pages       │  │   Controls   │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                   Application Layer                         │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │ Location Bloc   │  │ Permission Bloc │  │ Battery Bloc │ │
│  │                 │  │                 │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                    Domain Layer                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │ Location Entity │  │ Repository      │  │ Use Cases    │ │
│  │                 │  │ Interfaces      │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                Infrastructure Layer                         │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │ Background      │  │ Local Storage   │  │ API Client   │ │
│  │ Service         │  │ Queue           │  │              │ │
│  └─────────────────┘  └─────────────────┘  └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Components and Interfaces

### Core Components

#### 1. LocationService (Infrastructure)
- **Purpose**: Manages background GPS collection and coordinates all location operations
- **Platform Implementation**: Uses `geolocator` plugin with platform-specific background services
- **Key Methods**:
  - `startTracking()`: Initiates background location collection
  - `stopTracking()`: Stops location collection and cleans up resources
  - `getCurrentLocation()`: Gets single location point
  - `getLocationStream()`: Provides continuous location updates

#### 2. LocationRepository (Domain Interface)
- **Purpose**: Defines contract for location data operations
- **Methods**:
  - `startLocationTracking(TrackingConfig config)`
  - `stopLocationTracking()`
  - `sendLocationViaSocket(LocationPoint point)`
  - `queueLocationOffline(LocationPoint point)`
  - `syncQueuedLocations()`

#### 3. LocationQueue (Infrastructure)
- **Purpose**: Manages offline storage and synchronization of location points
- **Storage**: Uses `shared_preferences` for lightweight storage with JSON serialization
- **Key Features**:
  - FIFO queue with 1000 point limit
  - Batch upload (50 points per request)
  - Automatic cleanup of old points

#### 4. SocketService (Infrastructure)
- **Purpose**: Manages real-time WebSocket communication with backend
- **Features**:
  - Socket.IO connection management with auto-reconnection
  - Real-time GPS data streaming
  - Availability status broadcasting
  - Connection state monitoring and fallback handling
- **Key Methods**:
  - `connect()`: Establishes Socket.IO connection
  - `disconnect()`: Closes connection gracefully
  - `emitLocationUpdate(LocationPoint point)`: Streams GPS data
  - `emitAvailabilityChange(bool isAvailable)`: Broadcasts availability status
  - `onConnectionStateChanged()`: Handles connection events

#### 5. BatteryOptimizer (Infrastructure)
- **Purpose**: Adjusts GPS settings based on device conditions
- **Inputs**: Battery level, charging status, network quality, movement detection
- **Outputs**: Update frequency, GPS accuracy settings

#### 5. PermissionHandler (Infrastructure)
- **Purpose**: Manages location permission requests and status checking
- **Features**: 
  - Progressive permission requests (When in Use → Always)
  - Settings deep-linking for manual permission management
  - Permission status monitoring

#### 6. PermissionService (Infrastructure)
- **Purpose**: Handles all location permission operations and flows
- **Key Methods**:
  - `checkPermissionStatus()`: Returns current permission state
  - `requestLocationPermission()`: Initiates permission request flow
  - `openAppSettings()`: Opens device settings for manual permission management
  - `showPermissionExplanation()`: Displays explanation dialog

#### 7. AvailabilityToggle (Presentation)
- **Purpose**: Home page toggle widget that controls driver availability and location tracking
- **Features**:
  - Visual toggle switch with "Available" label
  - Active car information display when enabled
  - Real-time status updates
  - Integration with LocationBloc for state management

### State Management

#### LocationBloc
```dart
// Events
abstract class LocationEvent {}
class StartTracking extends LocationEvent {}
class StopTracking extends LocationEvent {}
class ToggleTracking extends LocationEvent {}
class LocationUpdated extends LocationEvent {
  final LocationPoint location;
}
class TrackingConfigChanged extends LocationEvent {
  final TrackingConfig config;
}

// States  
abstract class LocationState {}
class LocationInitial extends LocationState {}
class LocationTracking extends LocationState {
  final LocationPoint? currentLocation;
  final TrackingConfig config;
  final AvailabilityStatus availabilityStatus;
}
class LocationStopped extends LocationState {}
class LocationError extends LocationState {
  final String message;
}
```

#### PermissionBloc
```dart
// Events
abstract class PermissionEvent {}
class CheckPermissionStatus extends PermissionEvent {}
class RequestLocationPermission extends PermissionEvent {}
class ShowPermissionExplanation extends PermissionEvent {}
class OpenAppSettings extends PermissionEvent {}
class PermissionStatusChanged extends PermissionEvent {
  final LocationPermissionStatus status;
}

// States
abstract class PermissionBlocState {}
class PermissionInitial extends PermissionBlocState {}
class PermissionChecking extends PermissionBlocState {}
class PermissionGranted extends PermissionBlocState {
  final PermissionState permissionState;
}
class PermissionDenied extends PermissionBlocState {
  final PermissionState permissionState;
}
class PermissionExplanationRequired extends PermissionBlocState {}
class PermissionSettingsRequired extends PermissionBlocState {}
class PermissionError extends PermissionBlocState {
  final String message;
}
```

#### SocketBloc
```dart
// Events
abstract class SocketEvent {}
class ConnectSocket extends SocketEvent {}
class DisconnectSocket extends SocketEvent {}
class EmitLocationUpdate extends SocketEvent {
  final LocationPoint location;
}
class EmitAvailabilityChange extends SocketEvent {
  final bool isAvailable;
}
class SocketConnectionChanged extends SocketEvent {
  final SocketConnectionStatus status;
}
class SocketReconnectAttempt extends SocketEvent {}

// States
abstract class SocketBlocState {}
class SocketInitial extends SocketBlocState {}
class SocketConnecting extends SocketBlocState {}
class SocketConnected extends SocketBlocState {
  final SocketState socketState;
}
class SocketDisconnected extends SocketBlocState {
  final SocketState socketState;
}
class SocketReconnecting extends SocketBlocState {
  final SocketState socketState;
}
class SocketError extends SocketBlocState {
  final String message;
  final SocketState socketState;
}
```

## Data Models

### LocationPoint
```dart
@freezed
class LocationPoint with _$LocationPoint {
  const factory LocationPoint({
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    required double accuracy,
    double? speed,
    double? heading,
    double? altitude,
    @Default(false) bool isSynced,
  }) = _LocationPoint;
  
  factory LocationPoint.fromJson(Map<String, dynamic> json) =>
      _$LocationPointFromJson(json);
}
```

### TrackingConfig
```dart
@freezed
class TrackingConfig with _$TrackingConfig {
  const factory TrackingConfig({
    @Default(Duration(seconds: 3)) Duration updateInterval,
    @Default(LocationAccuracy.high) LocationAccuracy accuracy,
    @Default(10.0) double distanceFilter,
    @Default(true) bool enableBatteryOptimization,
  }) = _TrackingConfig;
}
```

### LocationQueueItem
```dart
@freezed
class LocationQueueItem with _$LocationQueueItem {
  const factory LocationQueueItem({
    required LocationPoint location,
    required DateTime queuedAt,
    @Default(0) int retryCount,
  }) = _LocationQueueItem;
  
  factory LocationQueueItem.fromJson(Map<String, dynamic> json) =>
      _$LocationQueueItemFromJson(json);
}
```

### AvailabilityStatus
```dart
@freezed
class AvailabilityStatus with _$AvailabilityStatus {
  const factory AvailabilityStatus({
    required bool isAvailable,
    String? activeCarModel,
    String? activeCarPlate,
    DateTime? lastLocationUpdate,
  }) = _AvailabilityStatus;
}
```

### LocationPermissionStatus
```dart
enum LocationPermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unknown,
}

@freezed
class PermissionState with _$PermissionState {
  const factory PermissionState({
    required LocationPermissionStatus status,
    required bool isServiceEnabled,
    DateTime? lastChecked,
  }) = _PermissionState;
}
```

### Socket Connection Models
```dart
enum SocketConnectionStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

@freezed
class SocketState with _$SocketState {
  const factory SocketState({
    required SocketConnectionStatus status,
    DateTime? lastConnected,
    DateTime? lastDisconnected,
    String? errorMessage,
    @Default(0) int reconnectAttempts,
  }) = _SocketState;
}

@freezed
class LocationUpdateEvent with _$LocationUpdateEvent {
  const factory LocationUpdateEvent({
    required String driverId,
    required LocationPoint location,
    required DateTime timestamp,
  }) = _LocationUpdateEvent;
  
  factory LocationUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$LocationUpdateEventFromJson(json);
}

@freezed
class AvailabilityChangeEvent with _$AvailabilityChangeEvent {
  const factory AvailabilityChangeEvent({
    required String driverId,
    required bool isAvailable,
    required DateTime timestamp,
    String? carModel,
    String? carPlate,
  }) = _AvailabilityChangeEvent;
  
  factory AvailabilityChangeEvent.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityChangeEventFromJson(json);
}
```

## User Interface Components

### Home Page Available Toggle
The main control interface for location tracking:

```dart
class AvailableToggleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PermissionBloc, PermissionBlocState>(
          listener: (context, permissionState) {
            if (permissionState is PermissionExplanationRequired) {
              _showPermissionExplanationDialog(context);
            } else if (permissionState is PermissionSettingsRequired) {
              _showPermissionSettingsDialog(context);
            }
          },
        ),
      ],
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.directions_car),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Available', style: Theme.of(context).textTheme.titleMedium),
                        if (state is LocationTracking && state.availabilityStatus.activeCarModel != null)
                          Text('Active Car: ${state.availabilityStatus.activeCarModel}, ${state.availabilityStatus.activeCarPlate}'),
                      ],
                    ),
                  ),
                  BlocBuilder<PermissionBloc, PermissionBlocState>(
                    builder: (context, permissionState) {
                      return Switch(
                        value: state is LocationTracking,
                        onChanged: permissionState is PermissionGranted ? (value) {
                          if (value) {
                            context.read<LocationBloc>().add(StartTracking());
                          } else {
                            context.read<LocationBloc>().add(StopTracking());
                          }
                        } : (value) {
                          if (value) {
                            context.read<PermissionBloc>().add(RequestLocationPermission());
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPermissionExplanationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PermissionExplanationDialog(),
    );
  }

  void _showPermissionSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PermissionSettingsDialog(),
    );
  }
}
```

### Permission UI Components

#### Permission Explanation Dialog
```dart
class PermissionExplanationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Location Access Required'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_on, size: 48, color: Theme.of(context).primaryColor),
          SizedBox(height: 16),
          Text(
            'To provide the best service, we need access to your location to:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 12),
          _buildFeatureItem('Track your trips accurately'),
          _buildFeatureItem('Optimize routes for efficiency'),
          _buildFeatureItem('Ensure driver safety'),
          _buildFeatureItem('Provide location-based services'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<PermissionBloc>().add(RequestLocationPermission());
          },
          child: Text('Grant Permission'),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
```

#### Permission Settings Dialog
```dart
class PermissionSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enable Location Access'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings, size: 48, color: Theme.of(context).primaryColor),
          SizedBox(height: 16),
          Text(
            'Please enable "Always" location access in your device settings to continue tracking in the background.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 12),
          Text(
            'Steps:\n1. Tap "Open Settings"\n2. Select "Location"\n3. Choose "Always"',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<PermissionBloc>().add(OpenAppSettings());
          },
          child: Text('Open Settings'),
        ),
      ],
    );
  }
}
```

Now I need to complete the prework analysis before writing the correctness properties section.

<function_calls>
<invoke name="prework">
<parameter name="featureName">background-location-streaming
#
# Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

Based on the prework analysis, I've identified several properties that can be combined for more comprehensive testing:

**Property Reflection:**
- Properties 4.1 and 4.2 can be combined into a single property about successful API transmission and cleanup
- Properties 5.3 and 5.4 can be combined into a comprehensive upload ordering and batching property
- Properties 6.1 and 6.2 can be combined into a shift-based tracking control property
- Properties 3.1, 3.2, 3.3, 3.4, and 3.5 can be consolidated into comprehensive battery optimization properties

### Core Properties

**Property 1: Location data completeness**
*For any* location point generated by the Location_Service, it should contain all required fields (timestamp, latitude, longitude, accuracy) with valid values and optional fields (speed, heading, altitude) when available
**Validates: Requirements 1.2**

**Property 2: Background tracking continuity**
*For any* tracking session, when the app is backgrounded or device is locked, location updates should continue to be generated within the specified 2-5 second intervals
**Validates: Requirements 1.1**

**Property 3: GPS accuracy adaptation**
*For any* change in GPS accuracy conditions, the Location_Service should adapt collection frequency appropriately to maintain optimal tracking
**Validates: Requirements 1.3**

**Property 4: Permission request progression**
*For any* permission state, the Permission_Flow should request the appropriate permission level (Always when not granted, upgrade guidance when only "While in Use" is granted)
**Validates: Requirements 2.2**

**Property 5: Battery level optimization**
*For any* battery level below 20%, the Battery_Optimizer should reduce GPS update frequency to 10-second intervals to conserve power
**Validates: Requirements 3.1**

**Property 6: Charging state optimization**
*For any* device charging state, the Battery_Optimizer should increase GPS accuracy and reduce update intervals to 2 seconds for optimal tracking
**Validates: Requirements 3.2**

**Property 7: Network-based optimization**
*For any* poor network connectivity condition, the Battery_Optimizer should reduce location collection frequency to conserve battery
**Validates: Requirements 3.3**

**Property 8: Stationary detection optimization**
*For any* device stationary for more than 5 minutes, the Battery_Optimizer should reduce update frequency to 30-second intervals, and restore normal frequency within 10 seconds when movement is detected
**Validates: Requirements 3.4, 3.5**

**Property 9: Real-time data transmission**
*For any* GPS data collected when Socket connection is active, the data should be streamed via Socket.IO immediately and removed from local storage upon confirmation
**Validates: Requirements 4.1, 4.2**

**Property 10: Socket retry logic**
*For any* Socket.IO transmission failure, the Location_Service should retry up to 3 times with exponential backoff before queuing
**Validates: Requirements 4.3**

**Property 11: Socket queuing fallback**
*For any* location point where all Socket retry attempts fail, the point should be stored in the Location_Queue for later synchronization
**Validates: Requirements 4.4**

**Property 12: Socket reconnection and synchronization**
*For any* network connectivity restoration, Socket connection should be re-established and all queued location points should be automatically synced
**Validates: Requirements 4.5**

**Property 13: Offline storage with metadata**
*For any* network unavailability, GPS points should be stored locally with complete timestamps and metadata
**Validates: Requirements 5.1**

**Property 14: Queue size management**
*For any* Location_Queue reaching 1000 location points, the oldest points should be removed to maintain storage limits (FIFO behavior)
**Validates: Requirements 5.2**

**Property 15: Chronological upload with batching**
*For any* queued location upload, points should be uploaded in chronological order with batches of up to 50 points per API request
**Validates: Requirements 5.3, 5.4**

**Property 16: Upload failure persistence**
*For any* failed queued upload attempt, the location points should be maintained for the next sync attempt
**Validates: Requirements 5.5**

**Property 17: Toggle-based tracking control**
*For any* Available toggle switch to ON, location tracking should begin, and for any toggle switch to OFF, tracking should stop and notifications should be cleared
**Validates: Requirements 6.1, 6.2**

**Property 18: Available status display**
*For any* active location tracking state, the "Available" status should be displayed with toggle in ON position and active car information visible
**Validates: Requirements 6.3**

**Property 19: Manual tracking control with data preservation**
*For any* manual toggle of location tracking off, tracking should stop immediately while preserving queued data, and when toggled on, should resume with current battery optimization settings
**Validates: Requirements 6.4, 6.5**

**Property 20: Socket connection establishment**
*For any* app start with valid authentication, Socket connection should be established to the backend WebSocket server
**Validates: Requirements 7.1**

**Property 21: Real-time location streaming**
*For any* location tracking enabled state, Socket connection should emit "location_update" events with GPS data in real-time
**Validates: Requirements 7.2**

**Property 22: Availability status broadcasting**
*For any* driver availability change, Socket connection should emit "availability_changed" events with current status
**Validates: Requirements 7.3**

**Property 23: Socket auto-reconnection**
*For any* Socket connection loss, the service should attempt to reconnect automatically with exponential backoff
**Validates: Requirements 7.4**

**Property 24: Socket state synchronization**
*For any* Socket connection restoration after disconnection, the service should sync missed location updates and current availability status
**Validates: Requirements 7.5**

## Error Handling

### Network Errors
- **Connection Timeout**: Implement 30-second timeout for API calls with automatic retry
- **Server Errors (5xx)**: Retry with exponential backoff, queue on persistent failure
- **Client Errors (4xx)**: Log error, don't retry, continue with next location point
- **Network Unavailable**: Immediately queue location points for later sync

### GPS Errors
- **Location Services Disabled**: Show user prompt to enable location services
- **GPS Signal Lost**: Continue with last known accuracy settings, retry GPS acquisition
- **Permission Denied**: Guide user through permission flow, disable tracking if permanently denied
- **Accuracy Too Low**: Increase GPS accuracy settings, extend timeout for better fix

### Battery and Performance
- **Low Memory**: Reduce queue size, batch process location points
- **Background Restrictions**: Request battery optimization exemption, show user guidance
- **App Termination**: Persist current state, resume on next app launch
- **Storage Full**: Clear oldest queued points, log storage warning

### Data Integrity
- **Invalid Location Data**: Validate coordinates, reject invalid points
- **Timestamp Conflicts**: Use device time with UTC conversion
- **Queue Corruption**: Implement checksum validation, rebuild queue if corrupted
- **Duplicate Points**: Filter duplicate locations within 1-meter radius and 5-second window

## Testing Strategy

### Unit Testing Approach
The testing strategy employs both unit tests and property-based tests to ensure comprehensive coverage:

**Unit Tests** will cover:
- Specific permission flow scenarios (explanation screen display, settings navigation)
- Error handling edge cases (network failures, GPS unavailability)
- State transitions in BLoCs (tracking start/stop, configuration changes)
- Data serialization/deserialization for LocationPoint and queue items
- Integration points between components

**Property-Based Testing Requirements:**
- **Library**: Use `test` package with custom property testing utilities for Dart/Flutter
- **Iterations**: Configure each property-based test to run a minimum of 100 iterations
- **Tagging**: Each property-based test must include a comment with the format: `**Feature: background-location-streaming, Property {number}: {property_text}**`
- **Implementation**: Each correctness property must be implemented by a single property-based test

### Property-Based Testing Approach
Property-based tests will verify universal behaviors across all valid inputs:

- **Location Data Generation**: Create generators for valid GPS coordinates, timestamps, and accuracy values
- **Battery State Simulation**: Generate various battery levels, charging states, and network conditions
- **Permission State Testing**: Test all combinations of location permission states
- **Queue Behavior**: Generate large datasets to test queue management and synchronization
- **Network Condition Simulation**: Test various network states (offline, poor connectivity, full connectivity)

### Test Data Generators
- **LocationPoint Generator**: Valid GPS coordinates within realistic ranges
- **Battery State Generator**: Battery levels (0-100%), charging states (true/false)
- **Network Quality Generator**: Connection types (none, poor, good, excellent)
- **Permission State Generator**: All possible location permission combinations
- **Time-based Generators**: Realistic timestamps, intervals, and durations

### Integration Testing
- **Background Service Testing**: Verify service continues when app is backgrounded
- **API Integration**: Test actual API calls with mock server responses
- **Platform-Specific Testing**: Validate iOS and Android background behavior differences
- **Permission Flow Testing**: End-to-end permission request and handling flows

The dual testing approach ensures that unit tests catch specific implementation bugs while property tests verify that the system behaves correctly across the full range of possible inputs and conditions.

## User Interface Components

### Home Page Location Toggle Card

The home page will feature a prominent location tracking toggle card that allows drivers to easily control GPS tracking:

#### LocationToggleCard Widget
```dart
class LocationToggleCard extends StatelessWidget {
  final bool isTrackingEnabled;
  final VoidCallback onToggle;
  final LocationPoint? currentLocation;
  final String trackingStatus;
  
  // Displays:
  // - Toggle switch for enabling/disabling tracking
  // - Current tracking status (Active/Inactive)
  // - Last known location timestamp
  // - Battery optimization indicator
  // - Network connectivity status
}
```

#### Toggle Behavior
- **Toggle ON**: Initiates permission check → starts background location service → shows tracking active status
- **Toggle OFF**: Stops location tracking → preserves queued data → shows tracking inactive status
- **Visual Feedback**: Real-time status updates, location accuracy indicator, battery impact display
- **Persistent State**: Toggle state persists across app restarts and device reboots

### Permission Flow UI

#### LocationPermissionPage
- **Explanation Screen**: Clear description of why location access is needed for driver safety and trip tracking
- **Permission Request**: Progressive permission requests (When in Use → Always)
- **Settings Navigation**: Deep-link to device settings for manual permission management
- **Status Confirmation**: Visual confirmation when permissions are successfully granted

#### Permission Status Indicators
- **Permission Granted**: Green checkmark with "Location Access Enabled" message
- **Permission Denied**: Red warning with "Enable Location Access" button
- **Partial Permission**: Yellow warning with "Upgrade to Always Allow" guidance

### Tracking Status Display

#### LocationStatusWidget
```dart
class LocationStatusWidget extends StatelessWidget {
  final LocationState locationState;
  
  // Shows:
  // - Current tracking status (Active/Inactive/Error)
  // - Last location update timestamp
  // - GPS accuracy level
  // - Battery optimization status
  // - Queued locations count (when offline)
}
```

## Platform-Specific Implementation

### Android Implementation
- **Background Service**: Uses Android Foreground Service with persistent notification
- **Battery Optimization**: Requests exemption from Doze mode and App Standby
- **Permissions**: Handles ACCESS_FINE_LOCATION and ACCESS_BACKGROUND_LOCATION
- **Notification**: Persistent notification showing "Tracking your location for safety"

### iOS Implementation  
- **Background Modes**: Configures location background mode in Info.plist
- **Location Manager**: Uses CLLocationManager with allowsBackgroundLocationUpdates
- **Permissions**: Handles When in Use and Always location permissions
- **Background App Refresh**: Ensures location updates continue when app is backgrounded

### Cross-Platform Considerations
- **Plugin Integration**: Uses `geolocator` plugin for unified location access
- **Permission Handling**: Uses `permission_handler` plugin for consistent permission management
- **Background Processing**: Platform-specific background service implementations
- **Battery Monitoring**: Uses `battery_plus` plugin for battery level monitoring

## Security and Privacy

### Data Protection
- **Location Encryption**: Encrypt location data in local storage using device keystore
- **API Security**: Use HTTPS with certificate pinning for API communications
- **Data Retention**: Automatically purge location data older than 30 days
- **User Consent**: Clear consent flow explaining data usage and retention policies

### Privacy Controls
- **Tracking Toggle**: Easy on/off control on home page
- **Data Deletion**: Option to delete all stored location history
- **Transparency**: Show user exactly what location data is being collected and transmitted
- **Minimal Data**: Only collect essential location fields required for operations

## Performance Optimization

### Memory Management
- **Location Buffer**: Limit in-memory location points to 100 items
- **Queue Management**: Efficient FIFO queue with automatic cleanup
- **Background Processing**: Minimize memory footprint when app is backgrounded
- **Garbage Collection**: Proper disposal of location streams and listeners

### Network Optimization
- **Batch Uploads**: Group location points for efficient API calls
- **Compression**: Compress location data payloads for reduced bandwidth
- **Retry Logic**: Intelligent retry with exponential backoff
- **Offline Handling**: Robust offline queue with automatic synchronization

### Battery Optimization
- **Adaptive Frequency**: Dynamic GPS update intervals based on conditions
- **Geofencing**: Reduce frequency when stationary using geofence detection
- **Network Awareness**: Adjust behavior based on WiFi vs cellular connectivity
- **Charging Detection**: Increase accuracy when device is charging

## Configuration and Settings

### TrackingConfiguration
```dart
@freezed
class TrackingConfiguration with _$TrackingConfiguration {
  const factory TrackingConfiguration({
    @Default(Duration(seconds: 3)) Duration normalUpdateInterval,
    @Default(Duration(seconds: 10)) Duration lowBatteryInterval,
    @Default(Duration(seconds: 2)) Duration chargingInterval,
    @Default(Duration(seconds: 30)) Duration stationaryInterval,
    @Default(LocationAccuracy.high) LocationAccuracy accuracy,
    @Default(10.0) double distanceFilter,
    @Default(1000) int maxQueueSize,
    @Default(50) int batchUploadSize,
    @Default(3) int maxRetryAttempts,
  }) = _TrackingConfiguration;
}
```

### Environment-Specific Settings
- **Development**: More frequent updates, detailed logging, mock location support
- **Staging**: Production-like settings with enhanced debugging
- **Production**: Optimized for battery life and network efficiency

## Monitoring and Analytics

### Performance Metrics
- **Location Accuracy**: Track GPS accuracy over time
- **Battery Impact**: Monitor battery drain caused by location tracking
- **Network Usage**: Measure data consumption for location uploads
- **Queue Performance**: Monitor offline queue size and sync success rates

### Error Tracking
- **Permission Failures**: Track permission denial rates and reasons
- **API Failures**: Monitor API call success/failure rates
- **Background Service**: Track service restart frequency and causes
- **Location Quality**: Monitor GPS signal quality and accuracy issues

### User Analytics
- **Toggle Usage**: Track how often drivers enable/disable location tracking
- **Permission Flow**: Monitor permission request success rates
- **Battery Optimization**: Track effectiveness of battery saving features
- **Offline Behavior**: Monitor offline queue usage patterns