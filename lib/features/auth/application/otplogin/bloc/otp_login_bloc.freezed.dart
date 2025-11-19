// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpLoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phone) phoneChanged,
    required TResult Function() submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phone)? phoneChanged,
    TResult? Function()? submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phone)? phoneChanged,
    TResult Function()? submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpPhoneChanged value) phoneChanged,
    required TResult Function(OtpLoginSubmitted value) submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpPhoneChanged value)? phoneChanged,
    TResult? Function(OtpLoginSubmitted value)? submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpPhoneChanged value)? phoneChanged,
    TResult Function(OtpLoginSubmitted value)? submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpLoginEventCopyWith<$Res> {
  factory $OtpLoginEventCopyWith(
          OtpLoginEvent value, $Res Function(OtpLoginEvent) then) =
      _$OtpLoginEventCopyWithImpl<$Res, OtpLoginEvent>;
}

/// @nodoc
class _$OtpLoginEventCopyWithImpl<$Res, $Val extends OtpLoginEvent>
    implements $OtpLoginEventCopyWith<$Res> {
  _$OtpLoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpLoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OtpPhoneChangedImplCopyWith<$Res> {
  factory _$$OtpPhoneChangedImplCopyWith(_$OtpPhoneChangedImpl value,
          $Res Function(_$OtpPhoneChangedImpl) then) =
      __$$OtpPhoneChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$$OtpPhoneChangedImplCopyWithImpl<$Res>
    extends _$OtpLoginEventCopyWithImpl<$Res, _$OtpPhoneChangedImpl>
    implements _$$OtpPhoneChangedImplCopyWith<$Res> {
  __$$OtpPhoneChangedImplCopyWithImpl(
      _$OtpPhoneChangedImpl _value, $Res Function(_$OtpPhoneChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$OtpPhoneChangedImpl(
      null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpPhoneChangedImpl implements OtpPhoneChanged {
  const _$OtpPhoneChangedImpl(this.phone);

  @override
  final String phone;

  @override
  String toString() {
    return 'OtpLoginEvent.phoneChanged(phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpPhoneChangedImpl &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone);

  /// Create a copy of OtpLoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpPhoneChangedImplCopyWith<_$OtpPhoneChangedImpl> get copyWith =>
      __$$OtpPhoneChangedImplCopyWithImpl<_$OtpPhoneChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phone) phoneChanged,
    required TResult Function() submit,
  }) {
    return phoneChanged(phone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phone)? phoneChanged,
    TResult? Function()? submit,
  }) {
    return phoneChanged?.call(phone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phone)? phoneChanged,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (phoneChanged != null) {
      return phoneChanged(phone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpPhoneChanged value) phoneChanged,
    required TResult Function(OtpLoginSubmitted value) submit,
  }) {
    return phoneChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpPhoneChanged value)? phoneChanged,
    TResult? Function(OtpLoginSubmitted value)? submit,
  }) {
    return phoneChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpPhoneChanged value)? phoneChanged,
    TResult Function(OtpLoginSubmitted value)? submit,
    required TResult orElse(),
  }) {
    if (phoneChanged != null) {
      return phoneChanged(this);
    }
    return orElse();
  }
}

abstract class OtpPhoneChanged implements OtpLoginEvent {
  const factory OtpPhoneChanged(final String phone) = _$OtpPhoneChangedImpl;

  String get phone;

  /// Create a copy of OtpLoginEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpPhoneChangedImplCopyWith<_$OtpPhoneChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpLoginSubmittedImplCopyWith<$Res> {
  factory _$$OtpLoginSubmittedImplCopyWith(_$OtpLoginSubmittedImpl value,
          $Res Function(_$OtpLoginSubmittedImpl) then) =
      __$$OtpLoginSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpLoginSubmittedImplCopyWithImpl<$Res>
    extends _$OtpLoginEventCopyWithImpl<$Res, _$OtpLoginSubmittedImpl>
    implements _$$OtpLoginSubmittedImplCopyWith<$Res> {
  __$$OtpLoginSubmittedImplCopyWithImpl(_$OtpLoginSubmittedImpl _value,
      $Res Function(_$OtpLoginSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OtpLoginSubmittedImpl implements OtpLoginSubmitted {
  const _$OtpLoginSubmittedImpl();

  @override
  String toString() {
    return 'OtpLoginEvent.submit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpLoginSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phone) phoneChanged,
    required TResult Function() submit,
  }) {
    return submit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phone)? phoneChanged,
    TResult? Function()? submit,
  }) {
    return submit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phone)? phoneChanged,
    TResult Function()? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpPhoneChanged value) phoneChanged,
    required TResult Function(OtpLoginSubmitted value) submit,
  }) {
    return submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpPhoneChanged value)? phoneChanged,
    TResult? Function(OtpLoginSubmitted value)? submit,
  }) {
    return submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpPhoneChanged value)? phoneChanged,
    TResult Function(OtpLoginSubmitted value)? submit,
    required TResult orElse(),
  }) {
    if (submit != null) {
      return submit(this);
    }
    return orElse();
  }
}

abstract class OtpLoginSubmitted implements OtpLoginEvent {
  const factory OtpLoginSubmitted() = _$OtpLoginSubmittedImpl;
}

/// @nodoc
mixin _$OtpLoginState {
  PhoneNumber get phoneNumber => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isCodeSent => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get infoMessage => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;

  /// Create a copy of OtpLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpLoginStateCopyWith<OtpLoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpLoginStateCopyWith<$Res> {
  factory $OtpLoginStateCopyWith(
          OtpLoginState value, $Res Function(OtpLoginState) then) =
      _$OtpLoginStateCopyWithImpl<$Res, OtpLoginState>;
  @useResult
  $Res call(
      {PhoneNumber phoneNumber,
      bool isLoading,
      bool isError,
      String errorMessage,
      bool isCodeSent,
      int expiresIn,
      String unit,
      String infoMessage,
      bool showErrorMessages});
}

/// @nodoc
class _$OtpLoginStateCopyWithImpl<$Res, $Val extends OtpLoginState>
    implements $OtpLoginStateCopyWith<$Res> {
  _$OtpLoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpLoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isCodeSent = null,
    Object? expiresIn = null,
    Object? unit = null,
    Object? infoMessage = null,
    Object? showErrorMessages = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
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
      isCodeSent: null == isCodeSent
          ? _value.isCodeSent
          : isCodeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      infoMessage: null == infoMessage
          ? _value.infoMessage
          : infoMessage // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpLoginStateImplCopyWith<$Res>
    implements $OtpLoginStateCopyWith<$Res> {
  factory _$$OtpLoginStateImplCopyWith(
          _$OtpLoginStateImpl value, $Res Function(_$OtpLoginStateImpl) then) =
      __$$OtpLoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PhoneNumber phoneNumber,
      bool isLoading,
      bool isError,
      String errorMessage,
      bool isCodeSent,
      int expiresIn,
      String unit,
      String infoMessage,
      bool showErrorMessages});
}

/// @nodoc
class __$$OtpLoginStateImplCopyWithImpl<$Res>
    extends _$OtpLoginStateCopyWithImpl<$Res, _$OtpLoginStateImpl>
    implements _$$OtpLoginStateImplCopyWith<$Res> {
  __$$OtpLoginStateImplCopyWithImpl(
      _$OtpLoginStateImpl _value, $Res Function(_$OtpLoginStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isCodeSent = null,
    Object? expiresIn = null,
    Object? unit = null,
    Object? infoMessage = null,
    Object? showErrorMessages = null,
  }) {
    return _then(_$OtpLoginStateImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
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
      isCodeSent: null == isCodeSent
          ? _value.isCodeSent
          : isCodeSent // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      infoMessage: null == infoMessage
          ? _value.infoMessage
          : infoMessage // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OtpLoginStateImpl extends _OtpLoginState {
  const _$OtpLoginStateImpl(
      {required this.phoneNumber,
      this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      this.isCodeSent = false,
      this.expiresIn = 0,
      this.unit = '',
      this.infoMessage = '',
      this.showErrorMessages = false})
      : super._();

  @override
  final PhoneNumber phoneNumber;
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
  final bool isCodeSent;
  @override
  @JsonKey()
  final int expiresIn;
  @override
  @JsonKey()
  final String unit;
  @override
  @JsonKey()
  final String infoMessage;
  @override
  @JsonKey()
  final bool showErrorMessages;

  @override
  String toString() {
    return 'OtpLoginState(phoneNumber: $phoneNumber, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, isCodeSent: $isCodeSent, expiresIn: $expiresIn, unit: $unit, infoMessage: $infoMessage, showErrorMessages: $showErrorMessages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpLoginStateImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isCodeSent, isCodeSent) ||
                other.isCodeSent == isCodeSent) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.infoMessage, infoMessage) ||
                other.infoMessage == infoMessage) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      isLoading,
      isError,
      errorMessage,
      isCodeSent,
      expiresIn,
      unit,
      infoMessage,
      showErrorMessages);

  /// Create a copy of OtpLoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpLoginStateImplCopyWith<_$OtpLoginStateImpl> get copyWith =>
      __$$OtpLoginStateImplCopyWithImpl<_$OtpLoginStateImpl>(this, _$identity);
}

abstract class _OtpLoginState extends OtpLoginState {
  const factory _OtpLoginState(
      {required final PhoneNumber phoneNumber,
      final bool isLoading,
      final bool isError,
      final String errorMessage,
      final bool isCodeSent,
      final int expiresIn,
      final String unit,
      final String infoMessage,
      final bool showErrorMessages}) = _$OtpLoginStateImpl;
  const _OtpLoginState._() : super._();

  @override
  PhoneNumber get phoneNumber;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  bool get isCodeSent;
  @override
  int get expiresIn;
  @override
  String get unit;
  @override
  String get infoMessage;
  @override
  bool get showErrorMessages;

  /// Create a copy of OtpLoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpLoginStateImplCopyWith<_$OtpLoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
