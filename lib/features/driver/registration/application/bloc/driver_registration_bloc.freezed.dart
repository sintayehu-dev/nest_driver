// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DriverRegistrationEvent {
  DriverRequestData get driverData => throw _privateConstructorUsedError;
  VehicleRequestData get vehicleData => throw _privateConstructorUsedError;
  List<DriverDocumentRequestData> get driverDocuments =>
      throw _privateConstructorUsedError;
  List<VehicleDocumentRequestData> get vehicleDocuments =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)
        submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)?
        submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)?
        submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DriverRegistrationSubmitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DriverRegistrationSubmitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DriverRegistrationSubmitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRegistrationEventCopyWith<DriverRegistrationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRegistrationEventCopyWith<$Res> {
  factory $DriverRegistrationEventCopyWith(DriverRegistrationEvent value,
          $Res Function(DriverRegistrationEvent) then) =
      _$DriverRegistrationEventCopyWithImpl<$Res, DriverRegistrationEvent>;
  @useResult
  $Res call(
      {DriverRequestData driverData,
      VehicleRequestData vehicleData,
      List<DriverDocumentRequestData> driverDocuments,
      List<VehicleDocumentRequestData> vehicleDocuments});

  $DriverRequestDataCopyWith<$Res> get driverData;
  $VehicleRequestDataCopyWith<$Res> get vehicleData;
}

/// @nodoc
class _$DriverRegistrationEventCopyWithImpl<$Res,
        $Val extends DriverRegistrationEvent>
    implements $DriverRegistrationEventCopyWith<$Res> {
  _$DriverRegistrationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverData = null,
    Object? vehicleData = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
  }) {
    return _then(_value.copyWith(
      driverData: null == driverData
          ? _value.driverData
          : driverData // ignore: cast_nullable_to_non_nullable
              as DriverRequestData,
      vehicleData: null == vehicleData
          ? _value.vehicleData
          : vehicleData // ignore: cast_nullable_to_non_nullable
              as VehicleRequestData,
      driverDocuments: null == driverDocuments
          ? _value.driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocumentRequestData>,
      vehicleDocuments: null == vehicleDocuments
          ? _value.vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocumentRequestData>,
    ) as $Val);
  }

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverRequestDataCopyWith<$Res> get driverData {
    return $DriverRequestDataCopyWith<$Res>(_value.driverData, (value) {
      return _then(_value.copyWith(driverData: value) as $Val);
    });
  }

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleRequestDataCopyWith<$Res> get vehicleData {
    return $VehicleRequestDataCopyWith<$Res>(_value.vehicleData, (value) {
      return _then(_value.copyWith(vehicleData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverRegistrationSubmittedImplCopyWith<$Res>
    implements $DriverRegistrationEventCopyWith<$Res> {
  factory _$$DriverRegistrationSubmittedImplCopyWith(
          _$DriverRegistrationSubmittedImpl value,
          $Res Function(_$DriverRegistrationSubmittedImpl) then) =
      __$$DriverRegistrationSubmittedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DriverRequestData driverData,
      VehicleRequestData vehicleData,
      List<DriverDocumentRequestData> driverDocuments,
      List<VehicleDocumentRequestData> vehicleDocuments});

  @override
  $DriverRequestDataCopyWith<$Res> get driverData;
  @override
  $VehicleRequestDataCopyWith<$Res> get vehicleData;
}

/// @nodoc
class __$$DriverRegistrationSubmittedImplCopyWithImpl<$Res>
    extends _$DriverRegistrationEventCopyWithImpl<$Res,
        _$DriverRegistrationSubmittedImpl>
    implements _$$DriverRegistrationSubmittedImplCopyWith<$Res> {
  __$$DriverRegistrationSubmittedImplCopyWithImpl(
      _$DriverRegistrationSubmittedImpl _value,
      $Res Function(_$DriverRegistrationSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverData = null,
    Object? vehicleData = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
  }) {
    return _then(_$DriverRegistrationSubmittedImpl(
      driverData: null == driverData
          ? _value.driverData
          : driverData // ignore: cast_nullable_to_non_nullable
              as DriverRequestData,
      vehicleData: null == vehicleData
          ? _value.vehicleData
          : vehicleData // ignore: cast_nullable_to_non_nullable
              as VehicleRequestData,
      driverDocuments: null == driverDocuments
          ? _value._driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocumentRequestData>,
      vehicleDocuments: null == vehicleDocuments
          ? _value._vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocumentRequestData>,
    ));
  }
}

/// @nodoc

class _$DriverRegistrationSubmittedImpl implements DriverRegistrationSubmitted {
  const _$DriverRegistrationSubmittedImpl(
      {required this.driverData,
      required this.vehicleData,
      required final List<DriverDocumentRequestData> driverDocuments,
      required final List<VehicleDocumentRequestData> vehicleDocuments})
      : _driverDocuments = driverDocuments,
        _vehicleDocuments = vehicleDocuments;

  @override
  final DriverRequestData driverData;
  @override
  final VehicleRequestData vehicleData;
  final List<DriverDocumentRequestData> _driverDocuments;
  @override
  List<DriverDocumentRequestData> get driverDocuments {
    if (_driverDocuments is EqualUnmodifiableListView) return _driverDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_driverDocuments);
  }

  final List<VehicleDocumentRequestData> _vehicleDocuments;
  @override
  List<VehicleDocumentRequestData> get vehicleDocuments {
    if (_vehicleDocuments is EqualUnmodifiableListView)
      return _vehicleDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicleDocuments);
  }

  @override
  String toString() {
    return 'DriverRegistrationEvent.submitted(driverData: $driverData, vehicleData: $vehicleData, driverDocuments: $driverDocuments, vehicleDocuments: $vehicleDocuments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRegistrationSubmittedImpl &&
            (identical(other.driverData, driverData) ||
                other.driverData == driverData) &&
            (identical(other.vehicleData, vehicleData) ||
                other.vehicleData == vehicleData) &&
            const DeepCollectionEquality()
                .equals(other._driverDocuments, _driverDocuments) &&
            const DeepCollectionEquality()
                .equals(other._vehicleDocuments, _vehicleDocuments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      driverData,
      vehicleData,
      const DeepCollectionEquality().hash(_driverDocuments),
      const DeepCollectionEquality().hash(_vehicleDocuments));

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRegistrationSubmittedImplCopyWith<_$DriverRegistrationSubmittedImpl>
      get copyWith => __$$DriverRegistrationSubmittedImplCopyWithImpl<
          _$DriverRegistrationSubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)
        submitted,
  }) {
    return submitted(
        driverData, vehicleData, driverDocuments, vehicleDocuments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)?
        submitted,
  }) {
    return submitted?.call(
        driverData, vehicleData, driverDocuments, vehicleDocuments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DriverRequestData driverData,
            VehicleRequestData vehicleData,
            List<DriverDocumentRequestData> driverDocuments,
            List<VehicleDocumentRequestData> vehicleDocuments)?
        submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(
          driverData, vehicleData, driverDocuments, vehicleDocuments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DriverRegistrationSubmitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DriverRegistrationSubmitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DriverRegistrationSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class DriverRegistrationSubmitted implements DriverRegistrationEvent {
  const factory DriverRegistrationSubmitted(
          {required final DriverRequestData driverData,
          required final VehicleRequestData vehicleData,
          required final List<DriverDocumentRequestData> driverDocuments,
          required final List<VehicleDocumentRequestData> vehicleDocuments}) =
      _$DriverRegistrationSubmittedImpl;

  @override
  DriverRequestData get driverData;
  @override
  VehicleRequestData get vehicleData;
  @override
  List<DriverDocumentRequestData> get driverDocuments;
  @override
  List<VehicleDocumentRequestData> get vehicleDocuments;

  /// Create a copy of DriverRegistrationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRegistrationSubmittedImplCopyWith<_$DriverRegistrationSubmittedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DriverRegistrationState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  DriverRegistrationResponse? get response =>
      throw _privateConstructorUsedError;
  bool get sessionCreated => throw _privateConstructorUsedError;

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRegistrationStateCopyWith<DriverRegistrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRegistrationStateCopyWith<$Res> {
  factory $DriverRegistrationStateCopyWith(DriverRegistrationState value,
          $Res Function(DriverRegistrationState) then) =
      _$DriverRegistrationStateCopyWithImpl<$Res, DriverRegistrationState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      bool isSuccess,
      DriverRegistrationResponse? response,
      bool sessionCreated});

  $DriverRegistrationResponseCopyWith<$Res>? get response;
}

/// @nodoc
class _$DriverRegistrationStateCopyWithImpl<$Res,
        $Val extends DriverRegistrationState>
    implements $DriverRegistrationStateCopyWith<$Res> {
  _$DriverRegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
    Object? response = freezed,
    Object? sessionCreated = null,
  }) {
    return _then(_value.copyWith(
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
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as DriverRegistrationResponse?,
      sessionCreated: null == sessionCreated
          ? _value.sessionCreated
          : sessionCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverRegistrationResponseCopyWith<$Res>? get response {
    if (_value.response == null) {
      return null;
    }

    return $DriverRegistrationResponseCopyWith<$Res>(_value.response!, (value) {
      return _then(_value.copyWith(response: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverRegistrationStateImplCopyWith<$Res>
    implements $DriverRegistrationStateCopyWith<$Res> {
  factory _$$DriverRegistrationStateImplCopyWith(
          _$DriverRegistrationStateImpl value,
          $Res Function(_$DriverRegistrationStateImpl) then) =
      __$$DriverRegistrationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isError,
      String errorMessage,
      bool isSuccess,
      DriverRegistrationResponse? response,
      bool sessionCreated});

  @override
  $DriverRegistrationResponseCopyWith<$Res>? get response;
}

/// @nodoc
class __$$DriverRegistrationStateImplCopyWithImpl<$Res>
    extends _$DriverRegistrationStateCopyWithImpl<$Res,
        _$DriverRegistrationStateImpl>
    implements _$$DriverRegistrationStateImplCopyWith<$Res> {
  __$$DriverRegistrationStateImplCopyWithImpl(
      _$DriverRegistrationStateImpl _value,
      $Res Function(_$DriverRegistrationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = null,
    Object? isSuccess = null,
    Object? response = freezed,
    Object? sessionCreated = null,
  }) {
    return _then(_$DriverRegistrationStateImpl(
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
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as DriverRegistrationResponse?,
      sessionCreated: null == sessionCreated
          ? _value.sessionCreated
          : sessionCreated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DriverRegistrationStateImpl extends _DriverRegistrationState {
  const _$DriverRegistrationStateImpl(
      {this.isLoading = false,
      this.isError = false,
      this.errorMessage = '',
      this.isSuccess = false,
      this.response,
      this.sessionCreated = false})
      : super._();

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
  final DriverRegistrationResponse? response;
  @override
  @JsonKey()
  final bool sessionCreated;

  @override
  String toString() {
    return 'DriverRegistrationState(isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage, isSuccess: $isSuccess, response: $response, sessionCreated: $sessionCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRegistrationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.sessionCreated, sessionCreated) ||
                other.sessionCreated == sessionCreated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isError, errorMessage,
      isSuccess, response, sessionCreated);

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRegistrationStateImplCopyWith<_$DriverRegistrationStateImpl>
      get copyWith => __$$DriverRegistrationStateImplCopyWithImpl<
          _$DriverRegistrationStateImpl>(this, _$identity);
}

abstract class _DriverRegistrationState extends DriverRegistrationState {
  const factory _DriverRegistrationState(
      {final bool isLoading,
      final bool isError,
      final String errorMessage,
      final bool isSuccess,
      final DriverRegistrationResponse? response,
      final bool sessionCreated}) = _$DriverRegistrationStateImpl;
  const _DriverRegistrationState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String get errorMessage;
  @override
  bool get isSuccess;
  @override
  DriverRegistrationResponse? get response;
  @override
  bool get sessionCreated;

  /// Create a copy of DriverRegistrationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRegistrationStateImplCopyWith<_$DriverRegistrationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
