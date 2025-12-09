# Unified WebSocket API — Implementation Specification (for Frontend)

> Namespace: **`/ws`**
> Transport: **Socket.IO** (WebSocket + fallback)
> Authentication: **JWT** passed at connection time (handshake).
>
> This document is a literal implementation reference derived from the `UnifiedWebSocketGateway` server file. It lists every event, exact event names, room names, payload shapes, response formats, and example client-side implementation snippets. Nothing is advisory — this is the *how-to* for the frontend to integrate exactly with that gateway.

---

# 1 — Connection & Authentication

**Socket URL (example)**

```
wss://api.example.com/ws
```

(use your domain; the server namespace is `/ws`)

**How token is read by the server on connection**

* `client.handshake.auth?.token`
* OR `client.handshake.headers.authorization` (server strips `Bearer `)
* OR `client.handshake.query?.token`

The server verifies JWT using a secret (server-side). The frontend **must** send a valid JWT when connecting.

**Connection example (socket.io-client)**

```ts
import { io } from "socket.io-client";

const token = "eyJ..."; // your JWT
const socket = io("https://api.example.com", {
  path: "/socket.io", // optional; depends on server config
  auth: { token },    // preferred (handshake.auth.token)
  // or:
  // extraHeaders: { Authorization: `Bearer ${token}` },
  // query: { token }
  transports: ["websocket"],
  upgrade: true,
  autoConnect: true,
  // namespace appended by URL: io("https://api.example.com/ws", { auth: { token } })
});

const nsSocket = io("https://api.example.com/ws", { auth: { token } });
// Use nsSocket for all emits/listeners
```

**Server auth events you'll receive**

* `auth:success` — emitted by server after successful auth.

  ```json
  {
    "success": true,
    "message": "Successfully authenticated",
    "user_id": "string",
    "role": "driver|rider|user|..."
  }
  ```
* `auth:error` — emitted if token missing/invalid, then server disconnects.

  ```json
  {
    "success": false,
    "message": "Invalid or missing authentication token"
  }
  ```

**Client should handle:**

```ts
nsSocket.on("auth:success", (payload) => { /* proceed */ });
nsSocket.on("auth:error", (payload) => { /* handle and stop */ });
```

---

# 2 — Rooms / Channel Naming Conventions

Use these exact room names to join/leave or for server-targeted emits:

* `booking:{booking_id}`

  * Room for a specific booking. Both rider and driver join. Example: `booking:abc123`

* `driver:{driver_id}`

  * Room representing one driver (for driver-specific broadcasts like `driver:location-update`)

* `channel:driver-location:{driver_id}`

  * Channel for broadcasting a driver's raw location updates to subscribed users. Example: `channel:driver-location:driver42`

* `channel:nearby-drivers` (global)

  * Room for users subscribed to nearby drivers. Server will `to('channel:nearby-drivers').emit(...)` for broadcasts.

* `nearby-drivers`

  * (Used by server when broadcasting driver:online payloads — `server.to('nearby-drivers').emit('driver:online', payload)`)

Note: the gateway joins/leaves rooms on server side using the exact strings above. Use the same strings when expecting broadcasts.

---

# 3 — Client → Server Events (exact names) and Payloads

For each event below: show event name, required/optional fields, and expected ack/response shape (server returns value from handler — use Socket.IO callback to receive).

> **Frontend pattern to receive handler return value**:

```ts
nsSocket.emit("event:name", payload, (response) => {
  // response is the returned value from the NestJS handler
});
```

---

## 3.1 `driver:register`

* **Purpose:** Driver tells server it is ready to receive ride requests.
* **Emit (no payload)**:

  ```ts
  nsSocket.emit("driver:register", null, (response) => {...})
  ```
* **Server response (success)**:

  ```json
  {
    "event": "driver:registered",
    "data": {
      "success": true,
      "message": "Driver {id} registered for ride requests",
      "driver_id": "string"
    }
  }
  ```
* **Server response (error)**: `driver:register-error` with `{ success: false, message: string }`

---

## 3.2 `rider:register`

* **Purpose:** Rider registers for matchmaking updates for a booking.
* **Emit payload:**

  ```ts
  { booking_id: "string" }
  ```
* **Server response (success)**:

  ```json
  {
    "event": "rider:registered",
    "data": { "success": true, "message": "Registered for matchmaking updates", "booking_id": "string" }
  }
  ```
* **Server response (error)**: `rider:register-error`

---

## 3.3 `booking:join`

* **Purpose:** Alternate way to join `booking:{id}` room.
* **Emit payload:**

  ```ts
  { booking_id: "string" }
  ```
* **Server response (success)**:

  ```json
  { "event": "booking:joined", "data": { "success": true, "message": "Joined booking room", "booking_id": "string" } }
  ```
* **Server response (error)**: `booking:join-error`

---

## 3.4 `location:update` **and** `driver:location-update`

* **Purpose:** Driver sends live location updates. Both event names are accepted (compatibility).
* **Emitter (driver only)**:

  ```ts
  {
    booking_id?: "string", // optional (if in booking)
    lat: number,           // required
    lon: number,           // required
    speed?: number,
    heading?: number,
    accuracy?: number,
    status?: string        // e.g. 'available', 'on_trip', 'offline'
  }
  ```
* **Server response (success)**:

  ```json
  {
    "event": "location:updated",
    "data": { "success": true, "timestamp": "ISO8601 string" }
  }
  ```
* **Server response (error)**:

  * `location:error` with `{ success: false, message: string }`
  * Possible error reasons: not authenticated, not driver, invalid coordinates, processing failure.

> Note: the server publishes the location into Kafka topic `driver.location.update` and will later broadcast updates to relevant rooms (e.g. `booking:{booking_id}` or `channel:driver-location:{driver_id}`) via Kafka consumer handling.

---

## 3.5 `driver:response`

* **Purpose:** Driver accepts/rejects a ride request.
* **Emit payload:**

  ```ts
  {
    booking_id: "string",       // required
    driver_id: "string",        // required
    response: "accept" | "reject",
    rejection_reason?: "string"
  }
  ```
* **Server response (success)**:

  ```json
  {
    "event": "driver:response-received",
    "data": { "success": true, "message": "Response recorded" }
  }
  ```
* **Server response (error)**: `driver:response-error` with `{ success:false, message: string }`
* **Side effects**:

  * If `accept`, server will `client.join("booking:{booking_id}")` for that driver.
  * Server forwards the response to matchmaking service via RPC.

---

## 3.6 `driver:arrived`

* **Purpose:** Driver declares they have arrived pickup location.

* **Emit payload:**

  ```ts
  {
    booking_id: "string",
    driver_id: "string"
  }
  ```

* **Server response (success)**:

  ```json
  {
    "event": "driver:arrived-success",
    "data": { "success": true, "message": "Marked as arrived" }
  }
  ```

* **Server response (error)**: `driver:arrived-error`

* **Side effects**:

  * Server publishes Kafka `driver.arrived` event with `{ booking_id, driver_id, timestamp }`.
  * Kafka consumer later broadcasts `driver:arrived` to `booking:{booking_id}`.

---

## 3.7 `trip:start`

* **Purpose:** Driver starts the trip.
* **Emit payload:**

  ```ts
  {
    booking_id: "string",
    driver_id: "string"
  }
  ```
* **Server response (success)**:

  ```json
  {
    "event": "trip:start-success",
    "data": {
      "success": true,
      "message": "Trip started",
      // plus fields returned from matchmaking RPC: result.data (trip info)
    }
  }
  ```
* **Server response (error)**: `trip:start-error`
* **Side effects**:

  * Forwards to matchmaking (RPC `trip.start`) and publishes Kafka topic `trip.started`.

---

## 3.8 `trip:complete`

* **Purpose:** Complete trip (driver or rider can emit).
* **Emit payload:**

  ```ts
  {
    trip_id: "string",
    booking_id: "string",
    driver_id: "string"
  }
  ```
* **Server response (success)**:

  ```json
  {
    "event": "trip:complete-success",
    "data": { "success": true, "message": "Trip completed", /* result.data fields */ }
  }
  ```
* **Server response (error)**: `trip:complete-error`
* **Side effects**:

  * Forwards to matchmaking RPC `trip.complete` and publishes Kafka `trip.completed`.

---

## 3.9 `trip:cancel`

* **Purpose:** Cancel ongoing trip.
* **Emit payload:**

  ```ts
  {
    trip_id: "string",
    booking_id: "string",
    driver_id: "string",
    cancelled_by: "driver" | "rider",
    reason?: "string"
  }
  ```
* **Server response (success)**:

  ```json
  { "event": "trip:cancel-success", "data": { "success": true, "message": "Trip cancelled" } }
  ```
* **Server response (error)**: `trip:cancel-error`
* **Side effects**:

  * Publishes Kafka `trip.cancelled`.

---

## 3.10 `subscribe:nearby`

* **Purpose:** Subscribe to broadcasts about nearby drivers (global room).
* **Emit payload:**

  ```ts
  { lat: number, lon: number, radius?: number } // radius in meters, default 10000
  ```
* **Server response (success)**:

  ```json
  { "success": true, "joined": "nearby-drivers" }
  ```
* **Server response (error)**:

  ```json
  { "success": false, "message": "Invalid coordinates" }
  ```
* **Side effects**:

  * Server does `client.join('nearby-drivers')`.
  * Server (via Kafka consumer) will `emit('driver:online'|'channel:driver-location'...)` to this room.

---

## 3.11 `driver:subscribe`

* **Purpose:** Subscribe to a single driver's full details and live location.
* **Emit payload:**

  ```ts
  { driver_id: "string" }
  ```
* **Server response (success)**:

  * The handler returns `{ success: true, message: "Subscribed to driver {id}" }` and also:
  * Immediately emits `driver:details` to the requesting client with the full driver payload (see **Server → Client** section below).
* **Server response (error)**:

  ```json
  { "event": "error", "data": { "success": false, "message": "Driver not found" } }
  ```
* **Side effects**:

  * Server does `client.join('driver:{driver_id}')`
  * Server will later broadcast live `driver:location-update` to `driver:{driver_id}` room.

---

## 3.12 `driver:unsubscribe`

* **Purpose:** Leave the `driver:{id}` room (stop receiving `driver:details` / location updates).
* **Emit payload:**

  ```ts
  { driver_id: "string" }
  ```
* **Server response (success)**:

  ```json
  { "success": true, "message": "Unsubscribed from driver {driver_id}" }
  ```
* **Server response (error)**: `{ event: 'error', data: { success:false, message: string } }`

---

## 3.13 `channel:subscribe`

* **Purpose:** Subscribe to named channels (e.g. driver-location or nearby-drivers).
* **Emit payload** (one of these):

  * Subscribe to specific driver IDs:

    ```ts
    { channel: "driver-location", driver_ids: ["driver1","driver2"] }
    ```
  * Subscribe to nearby:

    ```ts
    { channel: "nearby-drivers", lat: number, lon: number, radius?: number }
    ```
* **Server responses**

  * Success for driver-location:

    ```json
    { "event": "channel:subscribed", "data": { "success": true, "channel": "driver-location", "driver_ids": [...] } }
    ```
  * Success for nearby:

    ```json
    { "event": "channel:subscribed", "data": { "success": true, "channel": "nearby-drivers", "radius": number, "location": { lat, lon } } }
    ```
  * Error: `channel:error`

---

## 3.14 `channel:unsubscribe`

* **Purpose:** Leave channels.
* **Emit payload:**

  ```ts
  { channel: "driver-location" | "nearby-drivers", driver_ids?: ["id1","id2"] }
  ```
* **Server responses**

  * Success:

    ```json
    { "event": "channel:unsubscribed", "data": { "success": true, "channel": "..." } }
    ```
  * Error: `channel:error`

---

# 4 — Server → Client Events (emitted by server / Kafka consumer)

These events are emitted by the server — some are emitted directly inside handlers (immediate responses), others result from Kafka messages handled by `handleKafkaMessage(...)`.

**Listen for these events on the socket instance:**

```ts
nsSocket.on("event:name", (payload) => { ... });
```

### 4.1 `channel:driver-location`

* **Emitted to:** `channel:driver-location:{driver_id}` rooms and `channel:nearby-drivers`
* **Payload:** the Kafka `driver.location.live` payload (example):

  ```json
  {
    "driver_id": "string",
    "lat": number,
    "lon": number,
    "speed": number,
    "heading": number,
    "status": "string",
    "timestamp": "ISO8601",
    // any other fields produced by the location service
  }
  ```

### 4.2 `driver:online`

* **Emitted to:** `nearby-drivers`
* **Payload (v2.0 structure)**:

  ```json
  {
    "driver_id": "string",
    "lat": number,
    "lon": number,
    "heading": number,
    "speed": number,
    "status": "available" | "on_trip" | ...,
    "vehicle": {
      "make": "string",
      "model": "string",
      "year": number,
      "color": "string",
      "plate_number": "string"
    },
    "timestamp": "ISO8601"
  }
  ```

### 4.3 `driver:location-update`

* **Emitted to:** `driver:{driver_id}` room
* **Payload:**

  ```json
  {
    "driver_id": "string",
    "lat": number,
    "lon": number,
    "heading": number,
    "speed": number,
    "timestamp": "ISO8601",
    "is_live": true
  }
  ```

### 4.4 `matchmaking:ride-request`

* **Emitted to:** specific driver socket (server emits to driver socket id)
* **Payload:** Kafka `matchmaking.driver-request` payload (example):

  ```json
  {
    "booking_id": "string",
    "driver_id": "string",
    "pickup": { "lat": number, "lon": number },
    "dropoff": { "lat": number, "lon": number },
    "estimated_fare": number,
    "requested_at": "ISO8601",
    // other booking metadata
  }
  ```

### 4.5 `matchmaking:matched`

* **Emitted to:** `booking:{booking_id}` room
* **Payload:** Kafka `matchmaking.matched` payload (example):

  ```json
  {
    "booking_id":"string",
    "driver_id":"string",
    "rider_id":"string",
    "eta_seconds": number,
    "matched_at": "ISO8601",
    // etc
  }
  ```

### 4.6 `matchmaking:status-update`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `matchmaking.status` payload (example):

  ```json
  { "booking_id":"string", "status":"searching|assigned|no_drivers|..." , "timestamp":"ISO8601" }
  ```

### 4.7 `matchmaking:cancelled`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `matchmaking.cancelled` payload (example):

  ```json
  { "booking_id":"string", "reason":"string", "timestamp":"ISO8601" }
  ```

### 4.8 `trip:started`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `trip.started` payload (example):

  ```json
  {
    "booking_id":"string",
    "trip_id":"string",
    "driver_id":"string",
    "started_at":"ISO8601",
    // other trip metadata
  }
  ```

### 4.9 `trip:completed`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `trip.completed` payload (example):

  ```json
  {
    "booking_id":"string",
    "trip_id":"string",
    "fare": number,
    "completed_at":"ISO8601",
    // other fields
  }
  ```

### 4.10 `trip:cancelled`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `trip.cancelled` payload

### 4.11 `driver:arrived`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** Kafka `driver.arrived` payload:

  ```json
  { "booking_id":"string", "driver_id":"string", "timestamp":"ISO8601" }
  ```

### 4.12 `driver:details`

* **Emitted to:** the client who requested `driver:subscribe` (immediate emission)
* **Payload example**:

  ```json
  {
    "driver_id": "string",
    "name": "string",
    "phone": "string",
    "rating": number,
    "total_trips": number,
    "photo_url": "string | null",
    "license_number": "string | null",
    "vehicle": {
      "make": "string",
      "model": "string",
      "year": number,
      "color": "string",
      "plate_number": "string",
      "type": "string",
      "photo_url": "string | null"
    },
    "current_location": {
      "lat": number,
      "lon": number,
      "heading": number,
      "speed": number,
      "timestamp": "ISO8601",
      "is_live": boolean
    } | null,
    "status": "offline|available|on_trip|...",
    "last_seen": "ISO8601|null",
    "is_currently_in_trip": boolean,
    "current_trip_id": "string|null"
  }
  ```

### 4.13 `driver:location`

* **Emitted to:** `booking:{booking_id}`
* **Payload:** driver location updates for the rider in active booking (from `driver.location.update` topic)

  ```json
  {
    "driver_id":"string",
    "booking_id":"string",
    "lat": number,
    "lon": number,
    "speed": number,
    "heading": number,
    "timestamp":"ISO8601"
  }
  ```

---

# 5 — Kafka Topic → Event Mapping (server-side mapping; useful to know which server events correspond to backend topics)

(This is server behavior — frontend should expect the corresponding events above.)

* `driver.location.live` → emits `channel:driver-location` and `driver:online` and `driver:location-update`
* `driver.location.update` → emits `driver:location` to `booking:{booking_id}`
* `matchmaking.driver-request` → emits `matchmaking:ride-request` (to specific driver socket)
* `matchmaking.matched` → emits `matchmaking:matched` to `booking:{booking_id}`
* `matchmaking.status` → emits `matchmaking:status-update`
* `matchmaking.cancelled` → emits `matchmaking:cancelled`
* `trip.started` → emits `trip:started`
* `trip.completed` → emits `trip:completed`
* `trip.cancelled` → emits `trip:cancelled`
* `driver.arrived` → emits `driver:arrived`

---

# 6 — Error Response Shapes & Conventions

* Many handlers return objects shaped as:

  ```json
  { "event": "some-error", "data": { "success": false, "message": "..." } }
  ```

  or

  ```json
  { "success": false, "message": "..." }
  ```

  or

  ```json
  { "event": "something", "data": { "success": true, ... } }
  ```

* When using client `.emit(event, payload, ackCallback)` the `ackCallback` may receive either:

  * Success object (see specific handler)
  * Error object containing `success: false` and `message` property
  * Some handlers return a top-level object (not nested `event`), e.g. `{ success: true, joined: "nearby-drivers" }`

**Frontend should not assume a single consistent envelope** — check the handler's documented success and error shapes above for each event.

---

# 7 — TypeScript Types (copyable)

Use these types in the frontend to validate payloads and responses.

```ts
// Common
type Role = "driver" | "rider" | "user" | string;

interface AuthSuccess {
  success: true;
  message: string;
  user_id: string;
  role: Role;
}

interface AuthError {
  success: false;
  message: string;
}

// Location update (driver -> server)
interface LocationUpdatePayload {
  booking_id?: string;
  lat: number;
  lon: number;
  speed?: number;
  heading?: number;
  accuracy?: number;
  status?: string;
}

// Driver details (server -> client)
interface Vehicle {
  make: string;
  model: string;
  year: number;
  color: string;
  plate_number: string;
  type?: string;
  photo_url?: string | null;
}

interface DriverDetails {
  driver_id: string;
  name: string;
  phone?: string;
  rating?: number;
  total_trips?: number;
  photo_url?: string | null;
  license_number?: string | null;
  vehicle?: Vehicle | null;
  current_location?: {
    lat: number;
    lon: number;
    heading?: number;
    speed?: number;
    timestamp: string;
    is_live: boolean;
  } | null;
  status: string;
  last_seen?: string | null;
  is_currently_in_trip?: boolean;
  current_trip_id?: string | null;
}

// Matchmaking response (example)
interface MatchmakingRideRequest {
  booking_id: string;
  driver_id: string;
  pickup?: { lat: number; lon: number };
  dropoff?: { lat: number; lon: number };
  requested_at?: string;
  estimated_fare?: number;
}
```

---

# 8 — Example Client Code (full flows)

### Connect + receive auth

```ts
import { io } from "socket.io-client";

const token = "eyJ..."; // JWT
const socket = io("https://api.example.com/ws", {
  auth: { token },
  transports: ["websocket"]
});

socket.on("connect", () => {
  console.log("connected", socket.id);
});

socket.on("auth:success", (p) => console.log("AUTH OK", p));
socket.on("auth:error", (p) => {
  console.error("AUTH ERROR", p);
  socket.disconnect();
});
```

### Rider subscribes to booking + nearby drivers

```ts
// join booking
socket.emit("rider:register", { booking_id: "booking123" }, (res) => {
  console.log("rider:register ack:", res);
});

// subscribe to nearby drivers
socket.emit("subscribe:nearby", { lat: 37.7, lon: -122.4, radius: 2000 }, (res) => {
  console.log("subscribe:nearby ack:", res);
});

// listen for driver online
socket.on("driver:online", (payload) => {
  console.log("nearby driver online:", payload);
});

// listen for driver location updates for booking
socket.on("driver:location", (payload) => {
  console.log("driver location for booking:", payload);
});
```

### Rider subscribe to a single driver

```ts
socket.emit("driver:subscribe", { driver_id: "driver42" }, (res) => {
  console.log("driver:subscribe ack", res);
});
// server will emit driver:details immediately to you
socket.on("driver:details", (details) => {
  console.log("driver details", details);
});
// server will send driver:location-update to room driver:{driver_id}
socket.on("driver:location-update", (loc) => {
  console.log("driver live location", loc);
});
```

### Driver registration and sending locations

```ts
// driver registers
socket.emit("driver:register", null, (res) => console.log("driver:register", res));

// send location update
setInterval(() => {
  socket.emit("location:update", {
    lat: 37.7749,
    lon: -122.4194,
    speed: 12,
    heading: 90,
    booking_id: "booking123", // if in-trip
    status: "on_trip"
  }, (ack) => {
    console.log("location ack", ack);
  });
}, 3000);

// respond to ride request (from server matchmaking:ride-request)
socket.on("matchmaking:ride-request", (req) => {
  console.log("got ride request", req);
  // Accept:
  socket.emit("driver:response", { booking_id: req.booking_id, driver_id: "driver42", response: "accept" }, (ack) => {
    console.log("driver response ack:", ack);
  });
});
```

### Trip lifecycle (driver)

```ts
// start trip
socket.emit("trip:start", { booking_id:"booking123", driver_id:"driver42" }, (res) => {
  console.log("trip start ack", res);
});

// complete trip
socket.emit("trip:complete", { trip_id:"trip123", booking_id:"booking123", driver_id:"driver42" }, (res) => {
  console.log("trip complete ack", res);
});
```

---

# 9 — Validation rules enforced on server

* Coordinates are considered valid only if:

  * `lat` is `number` between `-90` and `90`
  * `lon` is `number` between `-180` and `180`
* Most driver-only events will return error if `user.role !== 'driver'` (server checks role extracted from JWT).
* Several handlers require the client to be authenticated (`connectedClients` mapping must exist for client id).

---

# 10 — Notes on JWT content (what server reads)

When the server verifies the token, it extracts user id and roles using multiple possible claim names:

* User id looked up using one of:

  * `decoded.driverId`
  * `decoded.driver_id`
  * `decoded.sub`
  * `decoded.user_id`
  * `decoded.userId`
  * `decoded.rider_id`
  * `decoded.riderId`

* Role:

  * Uses `decoded.roles` (array). If present, `roles[0]` is the role used; otherwise defaults to `'user'`.

**Therefore** the JWT you provide at connect should contain at least one of the user id claims above and optionally `roles` array so the server recognizes `driver` or `rider`.

---

# 11 — Exact Event Strings (quick reference)

Client → Server:

```
driver:register
rider:register
booking:join
location:update
driver:location-update
driver:response
driver:arrived
trip:start
trip:complete
trip:cancel
subscribe:nearby
driver:subscribe
driver:unsubscribe
channel:subscribe
channel:unsubscribe
```

Server → Client:

```
auth:success
auth:error
driver:registered
driver:register-error
rider:registered
rider:register-error
booking:joined
booking:join-error
location:updated
location:error
driver:response-received
driver:response-error
driver:arrived-success
driver:arrived-error
trip:start-success
trip:start-error
trip:complete-success
trip:complete-error
trip:cancel-success
trip:cancel-error
driver:details
driver:location
driver:location-update
driver:online
channel:driver-location
matchmaking:ride-request
matchmaking:matched
matchmaking:status-update
matchmaking:cancelled
trip:started
trip:completed
trip:cancelled
channel:subscribed
channel:unsubscribed
channel:error
```

---

# 12 — Recommended usage pattern (only implementation steps; not high-level advice)

Use Socket.IO `emit(event, payload, ack)` where you need server ack values returned by the handler.

Use `on(event, handler)` to subscribe to server-emitted events.

When joining booking rooms or driver rooms, either:

* Call the server handler events that cause server to join you (e.g., `rider:register`, `booking:join`, `driver:subscribe`), or
* Rely on the immediate-response behavior (e.g., `driver:subscribe` will cause server to emit `driver:details`).

---

# 13 — Example: Full Rider Flow (sequence)

1. Connect with JWT.
2. Get `auth:success`.
3. Register for booking updates:

   * `emit("rider:register", { booking_id }, ack)`
   * server will `client.join("booking:{booking_id}")`.
4. Listen on:

   * `matchmaking:matched`
   * `matchmaking:status-update`
   * `driver:arrived`
   * `driver:location` (for live driver updates)
   * `trip:started`
   * `trip:completed`
5. Optionally `emit("subscribe:nearby", {lat, lon})` to receive `driver:online` events.

---

# 14 — Example: Full Driver Flow (sequence)

1. Connect with JWT that includes `driver` role.
2. Get `auth:success`.
3. Call `emit("driver:register", null, ack)` to mark driver as available for requests.
4. Listen on:

   * `matchmaking:ride-request` (server will emit when there is a ride request)
5. On ride request, `emit("driver:response", { booking_id, driver_id, response: "accept" | "reject" }, ack)`

   * If `accept`, server will `join("booking:{booking_id}")`.
6. Start location updates periodically:

   * `emit("location:update", { lat, lon, speed, heading, booking_id? }, ack)`
7. When at pickup: `emit("driver:arrived", { booking_id, driver_id }, ack)`
8. Start trip: `emit("trip:start", { booking_id, driver_id }, ack)`
9. Complete/cancel: `emit("trip:complete", {...}, ack)` or `emit("trip:cancel", {...}, ack)`

---

# 15 — Miscellany / Important Implementation Details (literal)

* Namespace path is `/ws`. Connect to `https://your-host/ws`.
* The server uses Socket.IO `client.join(room)` on server side when appropriate — frontend should not rely on local-side `socket.join` (client cannot force server join; must call server handlers).
* The server sometimes returns a top-level `{ event, data }` object in ack callbacks. Use the ack callback to read returned object.
* Many server responses include a `success` boolean and `message` field. Use them to decide success vs failure.
* Roles derived from JWT are authoritative — ensure the token contains the expected claims (`driver` vs `rider`).
* Location live broadcasts are driven by Kafka topics published/consumed by server — the frontend will receive events asynchronously when Kafka messages arrive.

---

# 16 — Minimal Checklist for frontend implementers (exact actions to perform)

1. Connect to `https://{HOST}/ws` **with** JWT in `auth.token` (Socket.IO handshake).
2. Listen for `auth:success` or `auth:error`.
3. For rider:

   * `emit("rider:register", { booking_id }, ack)` or `emit("booking:join", { booking_id }, ack)`
   * Listen on `matchmaking:matched`, `driver:location`, `driver:arrived`, etc.
4. For driver:

   * `emit("driver:register", null, ack)`
   * Periodically `emit("location:update", locationPayload, ack)`
   * Listen `matchmaking:ride-request` and respond via `driver:response`.
5. To follow a driver: `emit("driver:subscribe", { driver_id }, ack)` and handle `driver:details` & `driver:location-update`.
6. To get nearby drivers: `emit("subscribe:nearby", { lat, lon, radius }, ack)` and listen for `driver:online` and `channel:driver-location`.

---

# 17 — Appendix — All payload shapes in one place

### `location:update` / `driver:location-update` (driver → server)

```ts
{
  booking_id?: string,
  lat: number,
  lon: number,
  speed?: number,
  heading?: number,
  accuracy?: number,
  status?: string
}
```

### `driver:response` (driver → server)

```ts
{ booking_id: string, driver_id: string, response: "accept"|"reject", rejection_reason?: string }
```

### `driver:arrived` (driver → server)

```ts
{ booking_id: string, driver_id: string }
```

### `trip:start` (driver → server)

```ts
{ booking_id: string, driver_id: string }
```

### `trip:complete` (driver/rider → server)

```ts
{ trip_id: string, booking_id: string, driver_id: string }
```

### `trip:cancel` (driver/rider → server)

```ts
{ trip_id: string, booking_id: string, driver_id: string, cancelled_by: "driver"|"rider", reason?: string }
```

### `subscribe:nearby` (user → server)

```ts
{ lat: number, lon: number, radius?: number }
```

### `driver:subscribe` / `driver:unsubscribe`

```ts
{ driver_id: string }
```

### `channel:subscribe`

```ts
// driver-location for specific drivers:
{ channel: "driver-location", driver_ids: string[] }

// nearby drivers:
{ channel: "nearby-drivers", lat: number, lon: number, radius?: number }
```

