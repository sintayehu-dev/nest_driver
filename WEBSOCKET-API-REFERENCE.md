# ConnectRide WebSocket API Reference

## Connection Details

```
URL:        ws://localhost:3001/ws
Protocol:   Socket.IO v4
Transport:  WebSocket
```

## Authentication

All connections require a valid JWT token passed in the handshake:

```javascript
// Socket.IO Client Connection
const socket = io("http://localhost:3001/ws", {
  auth: { token: "YOUR_JWT_TOKEN" },
  transports: ['websocket']
});
```

**Alternative auth methods:**
- Query param: `?token=YOUR_JWT_TOKEN`
- Header: `Authorization: Bearer YOUR_JWT_TOKEN`

---

## Events Reference

### 1. Authentication Events

#### `auth:success` (Server → Client)
Emitted immediately after successful connection and JWT verification.

```json
// EVENT: auth:success
// DIRECTION: Server → Client

{
  "success": true,
  "message": "Successfully authenticated",
  "user_id": "76339937-2b18-4636-9839-726002b20c9e",
  "role": "rider"
}
```

#### `auth:error` (Server → Client)
Emitted when authentication fails. Connection is disconnected after this.

```json
// EVENT: auth:error
// DIRECTION: Server → Client

{
  "success": false,
  "message": "Invalid or missing authentication token"
}
```

---

### 2. Nearby Drivers (Map Preview)

#### `subscribe:nearby` (Client → Server)
Subscribe to receive broadcasts of all online drivers in a radius.

```json
// EVENT: subscribe:nearby
// DIRECTION: Client → Server

// REQUEST
{
  "lat": 8.984464274221018,
  "lon": 38.79654652882558,
  "radius": 10000          // Optional, default 10000 meters (10km)
}

// RESPONSE (callback)
{
  "success": true,
  "joined": "nearby-drivers"
}

// ERROR RESPONSE
{
  "event": "error",
  "data": {
    "success": false,
    "message": "Invalid coordinates"
  }
}
```

#### `driver:online` (Server → Client)
Broadcasted to all subscribers in `nearby-drivers` room when a driver sends location update.

```json
// EVENT: driver:online
// DIRECTION: Server → Client (Broadcast)
// ROOM: nearby-drivers
// FREQUENCY: Every 3 seconds per active driver

{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "lat": 8.984532,
  "lon": 38.796612,
  "heading": 90,
  "speed": 28.5,
  "status": "available",
  "vehicle": {
    "make": "Toyota",
    "model": "Corolla",
    "year": 2021,
    "color": "White",
    "plate_number": "ET-12345"
  },
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

---

### 3. Single Driver Tracking

#### `driver:subscribe` (Client → Server)
Subscribe to a specific driver to get full details and live location updates.

```json
// EVENT: driver:subscribe
// DIRECTION: Client → Server

// REQUEST
{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// RESPONSE (callback)
{
  "success": true,
  "message": "Subscribed to driver 117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// ERROR RESPONSE
{
  "event": "error",
  "data": {
    "success": false,
    "message": "Driver not found"
  }
}
```

#### `driver:details` (Server → Client)
Emitted immediately after subscribing to a driver (within 100ms).

```json
// EVENT: driver:details
// DIRECTION: Server → Client
// TRIGGER: Immediate response to driver:subscribe

{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "name": "Peneal Feleke",
  "phone": "+251713939200",
  "rating": "4.85",
  "total_trips": 1247,
  "photo_url": "https://storage.example.com/drivers/peneal.jpg",
  "license_number": "DL-987654",
  "vehicle": {
    "make": "Toyota",
    "model": "Premio",
    "year": 2014,
    "color": "Silver",
    "plate_number": "AR-47252",
    "type": "Sedan",
    "photo_url": null
  },
  "current_location": {
    "lat": 8.984464,
    "lon": 38.796546,
    "heading": 90,
    "speed": 28.5,
    "timestamp": "2025-12-09T10:20:30.123Z",
    "is_live": true
  },
  "status": "available",
  "last_seen": "2025-12-09T10:20:30.123Z",
  "is_currently_in_trip": false,
  "current_trip_id": null
}

// WHEN DRIVER IS OFFLINE (no recent location updates)
{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "name": "Peneal Feleke",
  // ... same fields ...
  "current_location": {
    "lat": 8.984464,
    "lon": 38.796546,
    "heading": 90,
    "speed": 0,
    "timestamp": "2025-12-08T18:30:00.000Z",
    "is_live": false    // <-- false means last known location
  },
  "status": "offline",
  "last_seen": "2025-12-08T18:30:00.000Z"
}
```

#### `driver:location-update` (Server → Client)
Live location updates for subscribed driver (only if driver is online).

```json
// EVENT: driver:location-update
// DIRECTION: Server → Client
// ROOM: driver:{driver_id}
// FREQUENCY: Every 3 seconds while driver is online

{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "lat": 8.985123,
  "lon": 38.797890,
  "heading": 115,
  "speed": 32.1,
  "timestamp": "2025-12-09T10:20:33.456Z",
  "is_live": true
}
```

#### `driver:unsubscribe` (Client → Server)
Unsubscribe from a specific driver's updates.

```json
// EVENT: driver:unsubscribe
// DIRECTION: Client → Server

// REQUEST
{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// RESPONSE (callback)
{
  "success": true,
  "message": "Unsubscribed from driver 117f5f9a-6d93-47af-893c-70eb50443eeb"
}
```

---

### 4. Driver Registration & Location Updates

#### `driver:register` (Client → Server)
Register driver to receive ride requests. **Requires driver role.**

```json
// EVENT: driver:register
// DIRECTION: Client → Server
// ROLE: driver only

// REQUEST
// (no payload required)

// RESPONSE
{
  "event": "driver:registered",
  "data": {
    "success": true,
    "message": "Driver 117f5f9a-6d93-47af-893c-70eb50443eeb registered for ride requests",
    "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
  }
}

// ERROR RESPONSE (not a driver)
{
  "event": "driver:register-error",
  "data": {
    "success": false,
    "message": "Only drivers can register for ride requests"
  }
}
```

#### `location:update` (Client → Server)
Driver sends their current location. **Requires driver role.**

```json
// EVENT: location:update
// DIRECTION: Client → Server
// ROLE: driver only
// NOTE: driver_id is extracted from JWT, DO NOT include in payload

// REQUEST
{
  "lat": 8.984464274221018,
  "lon": 38.79654652882558,
  "speed": 28.5,
  "heading": 90,
  "accuracy": 5,
  "status": "available",    // "available" | "busy" | "offline"
  "booking_id": "optional-booking-id-if-on-trip"
}

// RESPONSE (callback)
{
  "event": "location:updated",
  "data": {
    "success": true,
    "timestamp": "2025-12-09T10:20:33.456Z"
  }
}

// ERROR RESPONSE
{
  "event": "location:error",
  "data": {
    "success": false,
    "message": "Invalid coordinates"
  }
}

// ERROR: Not a driver
{
  "event": "location:error",
  "data": {
    "success": false,
    "message": "Only drivers can send location updates"
  }
}
```

---

### 5. Booking & Matchmaking

#### `rider:register` (Client → Server)
Rider registers for matchmaking updates on a booking.

```json
// EVENT: rider:register
// DIRECTION: Client → Server

// REQUEST
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678"
}

// RESPONSE
{
  "event": "rider:registered",
  "data": {
    "success": true,
    "message": "Registered for matchmaking updates",
    "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678"
  }
}
```

#### `booking:join` (Client → Server)
Join a booking room to receive all booking-related events.

```json
// EVENT: booking:join
// DIRECTION: Client → Server

// REQUEST
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678"
}

// RESPONSE
{
  "event": "booking:joined",
  "data": {
    "success": true,
    "message": "Joined booking room",
    "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678"
  }
}
```

#### `matchmaking:ride-request` (Server → Client)
Sent to drivers when a new ride request is available.

```json
// EVENT: matchmaking:ride-request
// DIRECTION: Server → Client (to driver)
// TRIGGER: New booking created

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "rider": {
    "id": "c6f905f1-3cda-4028-ae9a-3b7995fc4b03",
    "name": "John Rider",
    "phone": "+251911223344",
    "rating": 4.9
  },
  "pickup": {
    "lat": 8.984464,
    "lon": 38.796546,
    "address": "Bole Road, Addis Ababa"
  },
  "dropoff": {
    "lat": 9.012345,
    "lon": 38.823456,
    "address": "Meskel Square, Addis Ababa"
  },
  "distance_km": 5.2,
  "estimated_fare": 250,
  "vehicle_type": "sedan",
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

#### `driver:response` (Client → Server)
Driver accepts or rejects a ride request.

```json
// EVENT: driver:response
// DIRECTION: Client → Server
// ROLE: driver only

// REQUEST - Accept
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "response": "accept"
}

// REQUEST - Reject
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "response": "reject",
  "rejection_reason": "Too far away"
}

// RESPONSE
{
  "event": "driver:response-received",
  "data": {
    "success": true,
    "message": "Response recorded"
  }
}
```

#### `matchmaking:matched` (Server → Client)
Broadcast when a driver is successfully matched to a booking.

```json
// EVENT: matchmaking:matched
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "driver": {
    "name": "Peneal Feleke",
    "phone": "+251713939200",
    "rating": 4.85,
    "photo_url": "https://storage.example.com/drivers/peneal.jpg",
    "vehicle": {
      "make": "Toyota",
      "model": "Premio",
      "color": "Silver",
      "plate_number": "AR-47252"
    }
  },
  "eta_minutes": 5,
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

#### `matchmaking:status-update` (Server → Client)
Booking status changes.

```json
// EVENT: matchmaking:status-update
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "status": "driver_assigned",  // searching | driver_assigned | driver_arrived | in_progress | completed | cancelled
  "message": "Driver has been assigned to your ride",
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

#### `matchmaking:cancelled` (Server → Client)
Booking was cancelled.

```json
// EVENT: matchmaking:cancelled
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "cancelled_by": "rider",  // rider | driver | system
  "reason": "Changed plans",
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

---

### 6. Trip Lifecycle

#### `driver:arrived` (Client → Server)
Driver marks themselves as arrived at pickup location.

```json
// EVENT: driver:arrived
// DIRECTION: Client → Server
// ROLE: driver only

// REQUEST
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// RESPONSE
{
  "event": "driver:arrived-success",
  "data": {
    "success": true,
    "message": "Marked as arrived"
  }
}
```

#### `driver:arrived` (Server → Client)
Broadcast to booking room when driver arrives.

```json
// EVENT: driver:arrived
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "timestamp": "2025-12-09T10:25:00.000Z"
}
```

#### `trip:start` (Client → Server)
Driver starts the trip after rider is in the vehicle.

```json
// EVENT: trip:start
// DIRECTION: Client → Server
// ROLE: driver only

// REQUEST
{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// RESPONSE
{
  "event": "trip:start-success",
  "data": {
    "success": true,
    "message": "Trip started",
    "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
    "started_at": "2025-12-09T10:30:00.000Z"
  }
}
```

#### `trip:started` (Server → Client)
Broadcast when trip begins.

```json
// EVENT: trip:started
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "started_at": "2025-12-09T10:30:00.000Z",
  "timestamp": "2025-12-09T10:30:00.000Z"
}
```

#### `driver:location` (Server → Client)
Driver location updates during active trip.

```json
// EVENT: driver:location
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}
// FREQUENCY: Every 3 seconds during trip

{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "lat": 8.990123,
  "lon": 38.801234,
  "speed": 35.5,
  "heading": 45,
  "timestamp": "2025-12-09T10:35:00.000Z"
}
```

#### `trip:complete` (Client → Server)
Driver completes the trip at destination.

```json
// EVENT: trip:complete
// DIRECTION: Client → Server
// ROLE: driver only

// REQUEST
{
  "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb"
}

// RESPONSE
{
  "event": "trip:complete-success",
  "data": {
    "success": true,
    "message": "Trip completed",
    "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
    "fare": {
      "base_fare": 50,
      "distance_fare": 156,
      "time_fare": 24,
      "total": 230,
      "currency": "ETB"
    },
    "distance_km": 5.2,
    "duration_minutes": 18
  }
}
```

#### `trip:completed` (Server → Client)
Broadcast when trip is completed.

```json
// EVENT: trip:completed
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "fare": {
    "base_fare": 50,
    "distance_fare": 156,
    "time_fare": 24,
    "total": 230,
    "currency": "ETB"
  },
  "distance_km": 5.2,
  "duration_minutes": 18,
  "completed_at": "2025-12-09T10:48:00.000Z",
  "timestamp": "2025-12-09T10:48:00.000Z"
}
```

#### `trip:cancel` (Client → Server)
Cancel an active trip.

```json
// EVENT: trip:cancel
// DIRECTION: Client → Server

// REQUEST
{
  "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "cancelled_by": "driver",  // "driver" | "rider"
  "reason": "Rider not at pickup location"
}

// RESPONSE
{
  "event": "trip:cancel-success",
  "data": {
    "success": true,
    "message": "Trip cancelled"
  }
}
```

#### `trip:cancelled` (Server → Client)
Broadcast when trip is cancelled.

```json
// EVENT: trip:cancelled
// DIRECTION: Server → Client
// ROOM: booking:{booking_id}

{
  "trip_id": "t9e8d7c6-5432-1098-7654-321fedcba987",
  "booking_id": "b8f5e9a2-1234-5678-9abc-def012345678",
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "cancelled_by": "driver",
  "reason": "Rider not at pickup location",
  "timestamp": "2025-12-09T10:32:00.000Z"
}
```

---

### 7. Legacy Channel Events (Backwards Compatibility)

#### `channel:subscribe` (Client → Server)

```json
// EVENT: channel:subscribe
// DIRECTION: Client → Server

// REQUEST - Subscribe to specific drivers
{
  "channel": "driver-location",
  "driver_ids": ["117f5f9a-6d93-47af-893c-70eb50443eeb", "another-driver-id"]
}

// REQUEST - Subscribe to nearby drivers
{
  "channel": "nearby-drivers",
  "lat": 8.984464,
  "lon": 38.796546,
  "radius": 10000
}

// RESPONSE
{
  "event": "channel:subscribed",
  "data": {
    "success": true,
    "channel": "driver-location",
    "driver_ids": ["117f5f9a-6d93-47af-893c-70eb50443eeb"]
  }
}
```

#### `channel:unsubscribe` (Client → Server)

```json
// EVENT: channel:unsubscribe
// DIRECTION: Client → Server

// REQUEST
{
  "channel": "driver-location",
  "driver_ids": ["117f5f9a-6d93-47af-893c-70eb50443eeb"]
}

// RESPONSE
{
  "event": "channel:unsubscribed",
  "data": {
    "success": true,
    "channel": "driver-location",
    "driver_ids": ["117f5f9a-6d93-47af-893c-70eb50443eeb"]
  }
}
```

#### `channel:driver-location` (Server → Client)
Legacy event for driver location updates.

```json
// EVENT: channel:driver-location
// DIRECTION: Server → Client
// ROOM: channel:driver-location:{driver_id} or channel:nearby-drivers

{
  "driver_id": "117f5f9a-6d93-47af-893c-70eb50443eeb",
  "lat": 8.984464,
  "lon": 38.796546,
  "speed": 28.5,
  "heading": 90,
  "status": "available",
  "timestamp": "2025-12-09T10:20:33.456Z"
}
```

---

## Error Handling

All errors follow this structure:

```json
{
  "event": "{original-event}:error",  // or just "error"
  "data": {
    "success": false,
    "message": "Human readable error message",
    "code": "ERROR_CODE"  // Optional
  }
}
```

### Common Error Codes

| Code | Message | Description |
|------|---------|-------------|
| `AUTH_FAILED` | Invalid or missing authentication token | JWT verification failed |
| `NOT_AUTHORIZED` | Only drivers can... | Role-based permission denied |
| `INVALID_COORDINATES` | Invalid coordinates | Lat/Lon out of range |
| `DRIVER_NOT_FOUND` | Driver not found | Driver ID doesn't exist |
| `BOOKING_NOT_FOUND` | Booking not found | Booking ID doesn't exist |

---

## JavaScript Client Examples

### Example 1: Rider App - View Nearby Drivers

```javascript
import { io } from 'socket.io-client';

const socket = io('http://localhost:3001/ws', {
  auth: { token: RIDER_JWT_TOKEN },
  transports: ['websocket']
});

// Wait for authentication
socket.on('auth:success', (data) => {
  console.log('Authenticated as:', data.user_id);

  // Subscribe to nearby drivers
  socket.emit('subscribe:nearby', {
    lat: 8.984464,
    lon: 38.796546,
    radius: 10000
  });
});

// Receive driver updates
socket.on('driver:online', (driver) => {
  console.log('Driver update:', driver);
  // Update map marker
});
```

### Example 2: Parent App - Track Child's Driver

```javascript
import { io } from 'socket.io-client';

const socket = io('http://localhost:3001/ws', {
  auth: { token: PARENT_JWT_TOKEN },
  transports: ['websocket']
});

socket.on('auth:success', () => {
  // Subscribe to specific driver
  socket.emit('driver:subscribe', {
    driver_id: 'assigned-driver-id'
  });
});

// Get immediate driver details
socket.on('driver:details', (details) => {
  console.log('Driver:', details.name);
  console.log('Vehicle:', details.vehicle.plate_number);
  console.log('Location:', details.current_location);
  console.log('Is Live:', details.current_location.is_live);
});

// Get live location updates
socket.on('driver:location-update', (location) => {
  console.log('New location:', location.lat, location.lon);
});
```

### Example 3: Driver App - Go Online & Accept Rides

```javascript
import { io } from 'socket.io-client';

const socket = io('http://localhost:3001/ws', {
  auth: { token: DRIVER_JWT_TOKEN },
  transports: ['websocket']
});

socket.on('auth:success', () => {
  // Register for ride requests
  socket.emit('driver:register');

  // Start broadcasting location
  setInterval(() => {
    navigator.geolocation.getCurrentPosition((pos) => {
      socket.emit('location:update', {
        lat: pos.coords.latitude,
        lon: pos.coords.longitude,
        speed: pos.coords.speed || 0,
        heading: pos.coords.heading || 0,
        accuracy: pos.coords.accuracy,
        status: 'available'
      });
    });
  }, 3000);
});

// Handle ride requests
socket.on('matchmaking:ride-request', (request) => {
  console.log('New ride request:', request);

  // Show to driver, then accept/reject
  socket.emit('driver:response', {
    booking_id: request.booking_id,
    driver_id: request.driver_id,
    response: 'accept'
  });
});

// Join booking room after accepting
socket.on('matchmaking:matched', (data) => {
  socket.emit('booking:join', { booking_id: data.booking_id });
});
```

---

## Testing with wscat

```bash
# Install wscat
npm install -g wscat

# Note: wscat doesn't support Socket.IO protocol directly
# Use the test scripts in ride-request-demo/ folder instead:

cd ride-request-demo
node listen-nearby.js          # Test nearby drivers
node listen-driver-id.js       # Test single driver tracking
node driver-emit-live-location.js  # Simulate driver
```

---

## Rate Limits

| Event | Limit | Window |
|-------|-------|--------|
| `location:update` | 20 requests | per minute |
| `subscribe:nearby` | 10 requests | per minute |
| `driver:subscribe` | 30 requests | per minute |

---

## Status Values

### Driver Status
| Value | Description |
|-------|-------------|
| `available` | Driver is online and can accept rides |
| `busy` | Driver is on an active trip |
| `offline` | Driver is not broadcasting location |

### Booking Status
| Value | Description |
|-------|-------------|
| `searching` | Looking for available drivers |
| `driver_assigned` | Driver matched to booking |
| `driver_arrived` | Driver at pickup location |
| `in_progress` | Trip is ongoing |
| `completed` | Trip finished |
| `cancelled` | Booking was cancelled |
