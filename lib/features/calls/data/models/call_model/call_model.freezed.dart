// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CallModel _$CallModelFromJson(Map<String, dynamic> json) {
  return _CallModel.fromJson(json);
}

/// @nodoc
mixin _$CallModel {
  @HiveField(0)
  String? get callId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get phoneNumber => throw _privateConstructorUsedError;
  @HiveField(2)
  CallType? get callType => throw _privateConstructorUsedError;
  @HiveField(3)
  CallStatus? get callStatus => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get dateTime => throw _privateConstructorUsedError;

  /// Serializes this CallModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallModelCopyWith<CallModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallModelCopyWith<$Res> {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) then) =
      _$CallModelCopyWithImpl<$Res, CallModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? callId,
      @HiveField(1) String? phoneNumber,
      @HiveField(2) CallType? callType,
      @HiveField(3) CallStatus? callStatus,
      @HiveField(4) String? dateTime});
}

/// @nodoc
class _$CallModelCopyWithImpl<$Res, $Val extends CallModel>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = freezed,
    Object? phoneNumber = freezed,
    Object? callType = freezed,
    Object? callStatus = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      callStatus: freezed == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatus?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallModelImplCopyWith<$Res>
    implements $CallModelCopyWith<$Res> {
  factory _$$CallModelImplCopyWith(
          _$CallModelImpl value, $Res Function(_$CallModelImpl) then) =
      __$$CallModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? callId,
      @HiveField(1) String? phoneNumber,
      @HiveField(2) CallType? callType,
      @HiveField(3) CallStatus? callStatus,
      @HiveField(4) String? dateTime});
}

/// @nodoc
class __$$CallModelImplCopyWithImpl<$Res>
    extends _$CallModelCopyWithImpl<$Res, _$CallModelImpl>
    implements _$$CallModelImplCopyWith<$Res> {
  __$$CallModelImplCopyWithImpl(
      _$CallModelImpl _value, $Res Function(_$CallModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = freezed,
    Object? phoneNumber = freezed,
    Object? callType = freezed,
    Object? callStatus = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_$CallModelImpl(
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      callStatus: freezed == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatus?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallModelImpl implements _CallModel {
  _$CallModelImpl(
      {@HiveField(0) this.callId,
      @HiveField(1) this.phoneNumber,
      @HiveField(2) this.callType,
      @HiveField(3) this.callStatus,
      @HiveField(4) this.dateTime});

  factory _$CallModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? callId;
  @override
  @HiveField(1)
  final String? phoneNumber;
  @override
  @HiveField(2)
  final CallType? callType;
  @override
  @HiveField(3)
  final CallStatus? callStatus;
  @override
  @HiveField(4)
  final String? dateTime;

  @override
  String toString() {
    return 'CallModel(callId: $callId, phoneNumber: $phoneNumber, callType: $callType, callStatus: $callStatus, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallModelImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.callStatus, callStatus) ||
                other.callStatus == callStatus) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, callId, phoneNumber, callType, callStatus, dateTime);

  /// Create a copy of CallModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallModelImplCopyWith<_$CallModelImpl> get copyWith =>
      __$$CallModelImplCopyWithImpl<_$CallModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallModelImplToJson(
      this,
    );
  }
}

abstract class _CallModel implements CallModel {
  factory _CallModel(
      {@HiveField(0) final String? callId,
      @HiveField(1) final String? phoneNumber,
      @HiveField(2) final CallType? callType,
      @HiveField(3) final CallStatus? callStatus,
      @HiveField(4) final String? dateTime}) = _$CallModelImpl;

  factory _CallModel.fromJson(Map<String, dynamic> json) =
      _$CallModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get callId;
  @override
  @HiveField(1)
  String? get phoneNumber;
  @override
  @HiveField(2)
  CallType? get callType;
  @override
  @HiveField(3)
  CallStatus? get callStatus;
  @override
  @HiveField(4)
  String? get dateTime;

  /// Create a copy of CallModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallModelImplCopyWith<_$CallModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
