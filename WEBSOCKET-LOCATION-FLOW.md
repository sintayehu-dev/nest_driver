# Background Location → WebSocket Flow

End-to-end flow for streaming driver GPS updates over Socket.IO, based on current implementation in `DriverLocationRemoteDataSourceImpl` and `WebSocketService`.

## Key Components
- `WebSocketService`: wraps Socket.IO client setup, connection state, emit/on helpers, and base diagnostics.
- `DriverLocationRemoteDataSourceImpl.streamLiveLocation`: bridges app location stream to WebSocket, buffers until connected, emits updates with acks, and surfaces `LocationUpdateAck` results.
- `DriverLocationRepositoryImpl.streamLiveLocation`: maps datasource stream to `Either<NetworkExceptions, LocationUpdateAck>` for the domain layer.
- Background producer: any `Stream<DriverLocationUpdate>` (e.g., background location service) feeding live GPS events.

## Connection Lifecycle
1. `streamLiveLocation` is called with a `Stream<DriverLocationUpdate>` and optional `onConnected`.
2. If not already connected, `_ws.connect()` is invoked with auth headers/query via `WebSocketService`.
3. A temporary queue collects outgoing updates until the `connect` event fires; once connected, queued updates flush in order.
4. Base listeners in `WebSocketService` log connect/disconnect/reconnect/error events for diagnostics.
5. On stream cancellation, the datasource unsubscribes from `location:error`, cancels the location subscription, and disconnects the socket.

## Event Contract
- Emit: `location:update` (client → server) with payload `DriverLocationUpdate.toJson()`.
- Ack handler: callback from `emitWithAck` is parsed into `LocationUpdateAck.fromJson`; unexpected formats are wrapped into a failure `LocationUpdateAck`.
- Error channel: `location:error` (server → client) is mapped to `controller.addError`.

## Happy Path (per update)
1. Location stream yields `DriverLocationUpdate`.
2. If socket not connected, update is enqueued; else `_ws.emit('location:update', payload, ackHandler)`.
3. Server responds via ack callback → parsed to `LocationUpdateAck` → emitted downstream.
4. Consumers (e.g., bloc/use-case) receive `Either.right(ack)` from repository.

## Failure & Recovery
- Pre-connect: updates buffer in-memory (`pendingUpdates`) until `connect` fires.
- Send failure: if socket disconnected mid-flight, update is queued again by the emit guard.
- Server-side error: `location:error` pushes an exception to the stream.
- Consumer-side error: stream surfaces errors; repository maps them to `NetworkExceptions`.
- Cancellation: socket is disconnected to avoid dangling connections.

## How to Use
```dart
final stream = repo.streamLiveLocation(
  driverUpdateStream,
  onConnected: () => log('WS ready; flushing queued updates'),
);

stream.listen(
  (either) => either.fold(
    (err) => log('send failed: $err'),
    (ack) => log('ack success=${ack.success} msg=${ack.message}'),
  ),
  onError: (e) => log('stream error: $e'),
);
```

## Operational Notes
- Auth: token pulled from `LocalStorage` and sent via Socket.IO auth, headers, and query params.
- Transport: forced `websocket`, path `/socket.io`, namespace `/ws`.
- Timeouts: Socket connect timeout 10s (see `OptionBuilder.setTimeout`).
- Cleanup: ensure `StreamSubscription.cancel()` is called to trigger socket disconnect.
