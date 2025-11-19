// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerifyOtpEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otp) otpChanged,
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otp)? otpChanged,
    TResult? Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otp)? otpChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerifyOtpChanged value) otpChanged,
    required TResult Function(VerifyOtpSubmitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerifyOtpChanged value)? otpChanged,
    TResult? Function(VerifyOtpSubmitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerifyOtpChanged value)? otpChanged,
    TResult Function(VerifyOtpSubmitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpEventCopyWith<$Res> {
  factory $VerifyOtpEventCopyWith(
          VerifyOtpEvent value, $Res Function(VerifyOtpEvent) then) =
      _$VerifyOtpEventCopyWithImpl<$Res, VerifyOtpEvent>;
}

/// @nodoc
class _$VerifyOtpEventCopyWithImpl<$Res, $Val extends VerifyOtpEvent>
    implements $VerifyOtpEventCopyWith<$Res> {
  _$VerifyOtpEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyOtpEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$VerifyOtpChangedImplCopyWith<$Res> {
  factory _$$VerifyOtpChangedImplCopyWith(_$VerifyOtpChangedImpl value,
          $Res Function(_$VerifyOtpChangedImpl) then) =
      __$$VerifyOtpChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String otp});
}

/// @nodoc
class __$$VerifyOtpChangedImplCopyWithImpl<$Res>
    extends _$VerifyOtpEventCopyWithImpl<$Res, _$VerifyOtpChangedImpl>
    implements _$$VerifyOtpChangedImplCopyWith<$Res> {
  __$$VerifyOtpChangedImplCopyWithImpl(_$VerifyOtpChangedImpl _value,
      $Res Function(_$VerifyOtpChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyOtpEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
  }) {
    return _then(_$VerifyOtpChangedImpl(
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyOtpChangedImpl implements VerifyOtpChanged {
  const _$VerifyOtpChangedImpl(this.otp);

  @override
  final String otp;

  @override
  String toString() {
    return 'VerifyOtpEvent.otpChanged(otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpChangedImpl &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otp);

  /// Create a copy of VerifyOtpEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpChangedImplCopyWith<_$VerifyOtpChangedImpl> get copyWith =>
      __$$VerifyOtpChangedImplCopyWithImpl<_$VerifyOtpChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otp) otpChanged,
    required TResult Function() submitted,
  }) {
    return otpChanged(otp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otp)? otpChanged,
    TResult? Function()? submitted,
  }) {
    return otpChanged?.call(otp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otp)? otpChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (otpChanged != null) {
      return otpChanged(otp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerifyOtpChanged value) otpChanged,
    required TResult Function(VerifyOtpSubmitted value) submitted,
  }) {
    return otpChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerifyOtpChanged value)? otpChanged,
    TResult? Function(VerifyOtpSubmitted value)? submitted,
  }) {
    return otpChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerifyOtpChanged value)? otpChanged,
    TResult Function(VerifyOtpSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (otpChanged != null) {
      return otpChanged(this);
    }
    return orElse();
  }
}

abstract class VerifyOtpChanged implements VerifyOtpEvent {
  const factory VerifyOtpChanged(final String otp) = _$VerifyOtpChangedImpl;

  String get otp;

  /// Create a copy of VerifyOtpEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOtpChangedImplCopyWith<_$VerifyOtpChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpSubmittedImplCopyWith<$Res> {
  factory _$$VerifyOtpSubmittedImplCopyWith(_$VerifyOtpSubmittedImpl value,
          $Res Function(_$VerifyOtpSubmittedImpl) then) =
      __$$VerifyOtpSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyOtpSubmittedImplCopyWithImpl<$Res>
    extends _$VerifyOtpEventCopyWithImpl<$Res, _$VerifyOtpSubmittedImpl>
    implements _$$VerifyOtpSubmittedImplCopyWith<$Res> {
  __$$VerifyOtpSubmittedImplCopyWithImpl(_$VerifyOtpSubmittedImpl _value,
      $Res Function(_$VerifyOtpSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyOtpEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyOtpSubmittedImpl implements VerifyOtpSubmitted {
  const _$VerifyOtpSubmittedImpl();

  @override
  String toString() {
    return 'VerifyOtpEvent.submitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyOtpSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otp) otpChanged,
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otp)? otpChanged,
    TResult? Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otp)? otpChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerifyOtpChanged value) otpChanged,
    required TResult Function(VerifyOtpSubmitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerifyOtpChanged value)? otpChanged,
    TResult? Function(VerifyOtpSubmitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerifyOtpChanged value)? otpChanged,
    TResult Function(VerifyOtpSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class VerifyOtpSubmitted implements VerifyOtpEvent {
  const factory VerifyOtpSubmitted() = _$VerifyOtpSubmittedImpl;
}

/// @nodoc
mixin _$VerifyOtpState {
  String get otp => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  OtpUser? get account => throw _privateConstructorUsedError;
  bool get sessionCreated => throw _privateConstructorUsedError;

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyOtpStateCopyWith<VerifyOtpState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOtpStateCopyWith<$Res> {
  factory $VerifyOtpStateCopyWith(
          VerifyOtpState value, $Res Function(VerifyOtpState) then) =
      _$VerifyOtpStateCopyWithImpl<$Res, VerifyOtpState>;
  @useResult
  $Res call(
      {String otp,
      bool isLoading,
      bool isError,
      String errorMessage,
      bool isSuccess,
      String? accessToken,
      String? refreshToken,
      OtpUser? account,
      bool sessionCreated});

  $OtpUserCopyWith<$Res>? get account;
}

/// @nodoc
class _$VerifyOtpStateCopyWithImpl<$Res, $Val extends VerifyOtpState>
    implements $VerifyOtpStateCopyWith<$Res> {
  _$VerifyOtpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? account = freezed,
    Object? sessionCreated = null,
  }) {
    return _then(_value.copyWith(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as OtpUser?,
      sessionCreated: null == sessionCreated
          ? _value.sessionCreated
          : sessionCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtpUserCopyWith<$Res>? get account {
    if (_value.account == null) {
      return null;
    }

    return $OtpUserCopyWith<$Res>(_value.account!, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VerifyOtpStateImplCopyWith<$Res>
    implements $VerifyOtpStateCopyWith<$Res> {
  factory _$$VerifyOtpStateImplCopyWith(_$VerifyOtpStateImpl value,
          $Res Function(_$VerifyOtpStateImpl) then) =
      __$$VerifyOtpStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String otp,
      bool isLoading,
      bool isError,
      String errorMessage,
      bool isSuccess,
      String? accessToken,
      String? refreshToken,
      OtpUser? account,
      bool sessionCreated});

  @override
  $OtpUserCopyWith<$Res>? get account;
}

/// @nodoc
class __$$VerifyOtpStateImplCopyWithImpl<$Res>
    extends _$VerifyOtpStateCopyWithImpl<$Res, _$VerifyOtpStateImpl>
    implements _$$VerifyOtpStateImplCopyWith<$Res> {
  __$$VerifyOtpStateImplCopyWithImpl(
      _$VerifyOtpStateImpl _value, $Res Function(_$VerifyOtpStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? account = freezed,
    Object? sessionCreated = null,
  }) {
    return _then(_$VerifyOtpStateImpl(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as OtpUser?,
      sessionCreated: null == sessionCreated
          ? _value.sessionCreated
          : sessionCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$VerifyOtpStateImpl extends _VerifyOtpState {
  const _$VerifyOtpStateImpl(
      {required this.otp,
      this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      this.isSuccess = false,
      this.accessToken,
      this.refreshToken,
      this.account,
      this.sessionCreated = false})
      : super._();

  @override
  final String otp;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final OtpUser? account;
  @override
  @JsonKey()
  final bool sessionCreated;

  @override
  String toString() {
    return 'VerifyOtpState(otp: $otp, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, isSuccess: $isSuccess, accessToken: $accessToken, refreshToken: $refreshToken, account: $account, sessionCreated: $sessionCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpStateImpl &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.sessionCreated, sessionCreated) ||
                other.sessionCreated == sessionCreated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      otp,
      isLoading,
      isError,
      errorMessage,
      isSuccess,
      accessToken,
      refreshToken,
      account,
      sessionCreated);

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpStateImplCopyWith<_$VerifyOtpStateImpl> get copyWith =>
      __$$VerifyOtpStateImplCopyWithImpl<_$VerifyOtpStateImpl>(
          this, _$identity);
}

abstract class _VerifyOtpState extends VerifyOtpState {
  const factory _VerifyOtpState(
      {required final String otp,
      final bool isLoading,
      final bool isError,
      final String errorMessage,
      final bool isSuccess,
      final String? accessToken,
      final String? refreshToken,
      final OtpUser? account,
      final bool sessionCreated}) = _$VerifyOtpStateImpl;
  const _VerifyOtpState._() : super._();

  @override
  String get otp;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  bool get isSuccess;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  OtpUser? get account;
  @override
  bool get sessionCreated;

  /// Create a copy of VerifyOtpState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOtpStateImplCopyWith<_$VerifyOtpStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
