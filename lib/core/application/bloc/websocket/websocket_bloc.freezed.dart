// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebSocketEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connect,
    required TResult Function() disconnect,
    required TResult Function() reconnect,
    required TResult Function(SocketConnectionStatus status) statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connect,
    TResult? Function()? disconnect,
    TResult? Function()? reconnect,
    TResult? Function(SocketConnectionStatus status)? statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connect,
    TResult Function()? disconnect,
    TResult Function()? reconnect,
    TResult Function(SocketConnectionStatus status)? statusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectWebSocket value) connect,
    required TResult Function(DisconnectWebSocket value) disconnect,
    required TResult Function(ReconnectWebSocket value) reconnect,
    required TResult Function(WebSocketStatusChanged value) statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectWebSocket value)? connect,
    TResult? Function(DisconnectWebSocket value)? disconnect,
    TResult? Function(ReconnectWebSocket value)? reconnect,
    TResult? Function(WebSocketStatusChanged value)? statusChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectWebSocket value)? connect,
    TResult Function(DisconnectWebSocket value)? disconnect,
    TResult Function(ReconnectWebSocket value)? reconnect,
    TResult Function(WebSocketStatusChanged value)? statusChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketEventCopyWith<$Res> {
  factory $WebSocketEventCopyWith(
          WebSocketEvent value, $Res Function(WebSocketEvent) then) =
      _$WebSocketEventCopyWithImpl<$Res, WebSocketEvent>;
}

/// @nodoc
class _$WebSocketEventCopyWithImpl<$Res, $Val extends WebSocketEvent>
    implements $WebSocketEventCopyWith<$Res> {
  _$WebSocketEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectWebSocketImplCopyWith<$Res> {
  factory _$$ConnectWebSocketImplCopyWith(_$ConnectWebSocketImpl value,
          $Res Function(_$ConnectWebSocketImpl) then) =
      __$$ConnectWebSocketImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectWebSocketImplCopyWithImpl<$Res>
    extends _$WebSocketEventCopyWithImpl<$Res, _$ConnectWebSocketImpl>
    implements _$$ConnectWebSocketImplCopyWith<$Res> {
  __$$ConnectWebSocketImplCopyWithImpl(_$ConnectWebSocketImpl _value,
      $Res Function(_$ConnectWebSocketImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConnectWebSocketImpl implements ConnectWebSocket {
  const _$ConnectWebSocketImpl();

  @override
  String toString() {
    return 'WebSocketEvent.connect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectWebSocketImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connect,
    required TResult Function() disconnect,
    required TResult Function() reconnect,
    required TResult Function(SocketConnectionStatus status) statusChanged,
  }) {
    return connect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connect,
    TResult? Function()? disconnect,
    TResult? Function()? reconnect,
    TResult? Function(SocketConnectionStatus status)? statusChanged,
  }) {
    return connect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connect,
    TResult Function()? disconnect,
    TResult Function()? reconnect,
    TResult Function(SocketConnectionStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectWebSocket value) connect,
    required TResult Function(DisconnectWebSocket value) disconnect,
    required TResult Function(ReconnectWebSocket value) reconnect,
    required TResult Function(WebSocketStatusChanged value) statusChanged,
  }) {
    return connect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectWebSocket value)? connect,
    TResult? Function(DisconnectWebSocket value)? disconnect,
    TResult? Function(ReconnectWebSocket value)? reconnect,
    TResult? Function(WebSocketStatusChanged value)? statusChanged,
  }) {
    return connect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectWebSocket value)? connect,
    TResult Function(DisconnectWebSocket value)? disconnect,
    TResult Function(ReconnectWebSocket value)? reconnect,
    TResult Function(WebSocketStatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(this);
    }
    return orElse();
  }
}

abstract class ConnectWebSocket implements WebSocketEvent {
  const factory ConnectWebSocket() = _$ConnectWebSocketImpl;
}

/// @nodoc
abstract class _$$DisconnectWebSocketImplCopyWith<$Res> {
  factory _$$DisconnectWebSocketImplCopyWith(_$DisconnectWebSocketImpl value,
          $Res Function(_$DisconnectWebSocketImpl) then) =
      __$$DisconnectWebSocketImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DisconnectWebSocketImplCopyWithImpl<$Res>
    extends _$WebSocketEventCopyWithImpl<$Res, _$DisconnectWebSocketImpl>
    implements _$$DisconnectWebSocketImplCopyWith<$Res> {
  __$$DisconnectWebSocketImplCopyWithImpl(_$DisconnectWebSocketImpl _value,
      $Res Function(_$DisconnectWebSocketImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DisconnectWebSocketImpl implements DisconnectWebSocket {
  const _$DisconnectWebSocketImpl();

  @override
  String toString() {
    return 'WebSocketEvent.disconnect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectWebSocketImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connect,
    required TResult Function() disconnect,
    required TResult Function() reconnect,
    required TResult Function(SocketConnectionStatus status) statusChanged,
  }) {
    return disconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connect,
    TResult? Function()? disconnect,
    TResult? Function()? reconnect,
    TResult? Function(SocketConnectionStatus status)? statusChanged,
  }) {
    return disconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connect,
    TResult Function()? disconnect,
    TResult Function()? reconnect,
    TResult Function(SocketConnectionStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectWebSocket value) connect,
    required TResult Function(DisconnectWebSocket value) disconnect,
    required TResult Function(ReconnectWebSocket value) reconnect,
    required TResult Function(WebSocketStatusChanged value) statusChanged,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectWebSocket value)? connect,
    TResult? Function(DisconnectWebSocket value)? disconnect,
    TResult? Function(ReconnectWebSocket value)? reconnect,
    TResult? Function(WebSocketStatusChanged value)? statusChanged,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectWebSocket value)? connect,
    TResult Function(DisconnectWebSocket value)? disconnect,
    TResult Function(ReconnectWebSocket value)? reconnect,
    TResult Function(WebSocketStatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }
}

abstract class DisconnectWebSocket implements WebSocketEvent {
  const factory DisconnectWebSocket() = _$DisconnectWebSocketImpl;
}

/// @nodoc
abstract class _$$ReconnectWebSocketImplCopyWith<$Res> {
  factory _$$ReconnectWebSocketImplCopyWith(_$ReconnectWebSocketImpl value,
          $Res Function(_$ReconnectWebSocketImpl) then) =
      __$$ReconnectWebSocketImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReconnectWebSocketImplCopyWithImpl<$Res>
    extends _$WebSocketEventCopyWithImpl<$Res, _$ReconnectWebSocketImpl>
    implements _$$ReconnectWebSocketImplCopyWith<$Res> {
  __$$ReconnectWebSocketImplCopyWithImpl(_$ReconnectWebSocketImpl _value,
      $Res Function(_$ReconnectWebSocketImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ReconnectWebSocketImpl implements ReconnectWebSocket {
  const _$ReconnectWebSocketImpl();

  @override
  String toString() {
    return 'WebSocketEvent.reconnect()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReconnectWebSocketImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connect,
    required TResult Function() disconnect,
    required TResult Function() reconnect,
    required TResult Function(SocketConnectionStatus status) statusChanged,
  }) {
    return reconnect();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connect,
    TResult? Function()? disconnect,
    TResult? Function()? reconnect,
    TResult? Function(SocketConnectionStatus status)? statusChanged,
  }) {
    return reconnect?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connect,
    TResult Function()? disconnect,
    TResult Function()? reconnect,
    TResult Function(SocketConnectionStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (reconnect != null) {
      return reconnect();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectWebSocket value) connect,
    required TResult Function(DisconnectWebSocket value) disconnect,
    required TResult Function(ReconnectWebSocket value) reconnect,
    required TResult Function(WebSocketStatusChanged value) statusChanged,
  }) {
    return reconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectWebSocket value)? connect,
    TResult? Function(DisconnectWebSocket value)? disconnect,
    TResult? Function(ReconnectWebSocket value)? reconnect,
    TResult? Function(WebSocketStatusChanged value)? statusChanged,
  }) {
    return reconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectWebSocket value)? connect,
    TResult Function(DisconnectWebSocket value)? disconnect,
    TResult Function(ReconnectWebSocket value)? reconnect,
    TResult Function(WebSocketStatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (reconnect != null) {
      return reconnect(this);
    }
    return orElse();
  }
}

abstract class ReconnectWebSocket implements WebSocketEvent {
  const factory ReconnectWebSocket() = _$ReconnectWebSocketImpl;
}

/// @nodoc
abstract class _$$WebSocketStatusChangedImplCopyWith<$Res> {
  factory _$$WebSocketStatusChangedImplCopyWith(
          _$WebSocketStatusChangedImpl value,
          $Res Function(_$WebSocketStatusChangedImpl) then) =
      __$$WebSocketStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SocketConnectionStatus status});
}

/// @nodoc
class __$$WebSocketStatusChangedImplCopyWithImpl<$Res>
    extends _$WebSocketEventCopyWithImpl<$Res, _$WebSocketStatusChangedImpl>
    implements _$$WebSocketStatusChangedImplCopyWith<$Res> {
  __$$WebSocketStatusChangedImplCopyWithImpl(
      _$WebSocketStatusChangedImpl _value,
      $Res Function(_$WebSocketStatusChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$WebSocketStatusChangedImpl(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SocketConnectionStatus,
    ));
  }
}

/// @nodoc

class _$WebSocketStatusChangedImpl implements WebSocketStatusChanged {
  const _$WebSocketStatusChangedImpl(this.status);

  @override
  final SocketConnectionStatus status;

  @override
  String toString() {
    return 'WebSocketEvent.statusChanged(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketStatusChangedImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketStatusChangedImplCopyWith<_$WebSocketStatusChangedImpl>
      get copyWith => __$$WebSocketStatusChangedImplCopyWithImpl<
          _$WebSocketStatusChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connect,
    required TResult Function() disconnect,
    required TResult Function() reconnect,
    required TResult Function(SocketConnectionStatus status) statusChanged,
  }) {
    return statusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connect,
    TResult? Function()? disconnect,
    TResult? Function()? reconnect,
    TResult? Function(SocketConnectionStatus status)? statusChanged,
  }) {
    return statusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connect,
    TResult Function()? disconnect,
    TResult Function()? reconnect,
    TResult Function(SocketConnectionStatus status)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectWebSocket value) connect,
    required TResult Function(DisconnectWebSocket value) disconnect,
    required TResult Function(ReconnectWebSocket value) reconnect,
    required TResult Function(WebSocketStatusChanged value) statusChanged,
  }) {
    return statusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectWebSocket value)? connect,
    TResult? Function(DisconnectWebSocket value)? disconnect,
    TResult? Function(ReconnectWebSocket value)? reconnect,
    TResult? Function(WebSocketStatusChanged value)? statusChanged,
  }) {
    return statusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectWebSocket value)? connect,
    TResult Function(DisconnectWebSocket value)? disconnect,
    TResult Function(ReconnectWebSocket value)? reconnect,
    TResult Function(WebSocketStatusChanged value)? statusChanged,
    required TResult orElse(),
  }) {
    if (statusChanged != null) {
      return statusChanged(this);
    }
    return orElse();
  }
}

abstract class WebSocketStatusChanged implements WebSocketEvent {
  const factory WebSocketStatusChanged(final SocketConnectionStatus status) =
      _$WebSocketStatusChangedImpl;

  SocketConnectionStatus get status;

  /// Create a copy of WebSocketEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketStatusChangedImplCopyWith<_$WebSocketStatusChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WebSocketState {
  SocketConnectionStatus get status => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SocketConnectionStatus status) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SocketConnectionStatus status)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SocketConnectionStatus status)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketStateCopyWith<WebSocketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketStateCopyWith<$Res> {
  factory $WebSocketStateCopyWith(
          WebSocketState value, $Res Function(WebSocketState) then) =
      _$WebSocketStateCopyWithImpl<$Res, WebSocketState>;
  @useResult
  $Res call({SocketConnectionStatus status});
}

/// @nodoc
class _$WebSocketStateCopyWithImpl<$Res, $Val extends WebSocketState>
    implements $WebSocketStateCopyWith<$Res> {
  _$WebSocketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SocketConnectionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $WebSocketStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SocketConnectionStatus status});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$WebSocketStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SocketConnectionStatus,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({this.status = SocketConnectionStatus.disconnected});

  @override
  @JsonKey()
  final SocketConnectionStatus status;

  @override
  String toString() {
    return 'WebSocketState.initial(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SocketConnectionStatus status) initial,
  }) {
    return initial(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SocketConnectionStatus status)? initial,
  }) {
    return initial?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SocketConnectionStatus status)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements WebSocketState {
  const factory _Initial({final SocketConnectionStatus status}) = _$InitialImpl;

  @override
  SocketConnectionStatus get status;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
