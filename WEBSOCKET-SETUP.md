# WebSocket Setup & Location Availability

Quick reference for WebSocket connection and driver location streaming in Nest Driver.

## WebSocket Service

### Connection
```dart
// Inject WebSocketService
@injectable
class MyService {
  final WebSocketService _ws;
  
  void connect() {
    _ws.connect(
      namespace: '/ws',
      socketPath: '/socket.io',
      autoConnect: true,
    );
  }
}
```

### Key Methods
- `connect()` - Establish connection with JWT auth
- `disconnect()` - Close connection
- `emit(event, data, [ack])` - Send event to server
- `on(event, handler)` - Listen for server events
- `off(event, [handler])` - Remove listener
- `isConnected` - Check connection status
- `socketId` - Get current socket ID

## Driver Location Flow

### 1. Register as Available Driver
```dart
// After authentication
_ws.emit('driver:register');

// Listen for confirmation
_ws.on('driver:registered', (data) {
  print('Registered: ${data['driver_id']}');
});
```

### 2. Stream Location Updates
```dart
// Send location every 3 seconds
_ws.emit('location:update', {
  'lat': 8.984464,
  'lon': 38.796546,
  'speed': 28.5,
  'heading': 90,
  'accuracy': 5,
  'status': 'available',  // available | busy | offline
});

// Handle acknowledgment
_ws.emit('location:update', locationData, (ack) {
  if (ack['success']) {
    print('Location updated: ${ack['timestamp']}');
  }
});
```

### 3. Repository Implementation
```dart
@override
Stream<Either<NetworkExceptions, LocationUpdateAck>> streamLiveLocation(
  Stream<DriverLocationUpdate> locationStream,
  VoidCallback? onConnected,
) {
  return _remoteDataSource.streamLiveLocation(
    locationStream,
    onConnected: onConnected,
  );
}
```

## Driver Status Values

| Status | Description |
|--------|-------------|
| `available` | Online and ready for trips |
| `busy` | Currently on a trip |
| `offline` | Not accepting trips |

## Location Update Payload

```dart
{
  "lat": 8.984464,           // Required: latitude
  "lon": 38.796546,          // Required: longitude
  "speed": 28.5,             // Optional: speed in m/s
  "heading": 90,             // Optional: direction in degrees
  "accuracy": 5,             // Optional: GPS accuracy in meters
  "status": "available",     // Required: driver status
  "booking_id": "uuid"       // Optional: if on active trip
}
```

## Connection Lifecycle

1. **Connect** - `WebSocketService.connect()` with JWT token
2. **Auth** - Server validates token, emits `auth:success`
3. **Register** - Driver emits `driver:register`
4. **Stream** - Send `location:update` every 3 seconds
5. **Disconnect** - Call `disconnect()` when going offline

## Error Handling

```dart
// Listen for location errors
_ws.on('location:error', (error) {
  print('Location error: ${error['message']}');
});

// Handle connection errors
_ws.on('connect_error', (error) {
  print('Connection failed: $error');
});
```

## Background Location Integration

```dart
// Example with background location stream
final locationStream = backgroundLocationService.getLocationStream();

final wsStream = repository.streamLiveLocation(
  locationStream,
  onConnected: () => print('WebSocket connected'),
);

wsStream.listen(
  (either) => either.fold(
    (error) => handleError(error),
    (ack) => print('Update sent: ${ack.success}'),
  ),
);
```

## Key Events

### Driver → Server
- `driver:register` - Register for ride requests
- `location:update` - Send current location
- `driver:response` - Accept/reject ride request
- `driver:arrived` - Mark arrival at pickup
- `trip:start` - Start trip
- `trip:complete` - Complete trip

### Server → Driver
- `auth:success` - Authentication confirmed
- `matchmaking:ride-request` - New ride available
- `location:updated` - Location update acknowledged
- `location:error` - Location update failed

## Rate Limits
- `location:update`: 20 requests per minute
- Recommended interval: 3 seconds

## Notes
- Token auto-loaded from `LocalStorage`
- Connection auto-reconnects on failure
- Updates queued until connection established
- Socket disconnects on stream cancellation
