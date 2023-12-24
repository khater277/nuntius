// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallNotificationData _$CallNotificationDataFromJson(Map<String, dynamic> json) {
  return _CallNotificationData.fromJson(json);
}

/// @nodoc
mixin _$CallNotificationData {
  String? get to => throw _privateConstructorUsedError;
  String? get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  CallData? get callData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallNotificationDataCopyWith<CallNotificationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallNotificationDataCopyWith<$Res> {
  factory $CallNotificationDataCopyWith(CallNotificationData value,
          $Res Function(CallNotificationData) then) =
      _$CallNotificationDataCopyWithImpl<$Res, CallNotificationData>;
  @useResult
  $Res call(
      {String? to,
      String? priority,
      @JsonKey(name: 'data') CallData? callData});

  $CallDataCopyWith<$Res>? get callData;
}

/// @nodoc
class _$CallNotificationDataCopyWithImpl<$Res,
        $Val extends CallNotificationData>
    implements $CallNotificationDataCopyWith<$Res> {
  _$CallNotificationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = freezed,
    Object? priority = freezed,
    Object? callData = freezed,
  }) {
    return _then(_value.copyWith(
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
      callData: freezed == callData
          ? _value.callData
          : callData // ignore: cast_nullable_to_non_nullable
              as CallData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallDataCopyWith<$Res>? get callData {
    if (_value.callData == null) {
      return null;
    }

    return $CallDataCopyWith<$Res>(_value.callData!, (value) {
      return _then(_value.copyWith(callData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallNotificationDataImplCopyWith<$Res>
    implements $CallNotificationDataCopyWith<$Res> {
  factory _$$CallNotificationDataImplCopyWith(_$CallNotificationDataImpl value,
          $Res Function(_$CallNotificationDataImpl) then) =
      __$$CallNotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? to,
      String? priority,
      @JsonKey(name: 'data') CallData? callData});

  @override
  $CallDataCopyWith<$Res>? get callData;
}

/// @nodoc
class __$$CallNotificationDataImplCopyWithImpl<$Res>
    extends _$CallNotificationDataCopyWithImpl<$Res, _$CallNotificationDataImpl>
    implements _$$CallNotificationDataImplCopyWith<$Res> {
  __$$CallNotificationDataImplCopyWithImpl(_$CallNotificationDataImpl _value,
      $Res Function(_$CallNotificationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = freezed,
    Object? priority = freezed,
    Object? callData = freezed,
  }) {
    return _then(_$CallNotificationDataImpl(
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
      callData: freezed == callData
          ? _value.callData
          : callData // ignore: cast_nullable_to_non_nullable
              as CallData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallNotificationDataImpl implements _CallNotificationData {
  _$CallNotificationDataImpl(
      {this.to, this.priority, @JsonKey(name: 'data') this.callData});

  factory _$CallNotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallNotificationDataImplFromJson(json);

  @override
  final String? to;
  @override
  final String? priority;
  @override
  @JsonKey(name: 'data')
  final CallData? callData;

  @override
  String toString() {
    return 'CallNotificationData(to: $to, priority: $priority, callData: $callData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallNotificationDataImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.callData, callData) ||
                other.callData == callData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, to, priority, callData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallNotificationDataImplCopyWith<_$CallNotificationDataImpl>
      get copyWith =>
          __$$CallNotificationDataImplCopyWithImpl<_$CallNotificationDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallNotificationDataImplToJson(
      this,
    );
  }
}

abstract class _CallNotificationData implements CallNotificationData {
  factory _CallNotificationData(
          {final String? to,
          final String? priority,
          @JsonKey(name: 'data') final CallData? callData}) =
      _$CallNotificationDataImpl;

  factory _CallNotificationData.fromJson(Map<String, dynamic> json) =
      _$CallNotificationDataImpl.fromJson;

  @override
  String? get to;
  @override
  String? get priority;
  @override
  @JsonKey(name: 'data')
  CallData? get callData;
  @override
  @JsonKey(ignore: true)
  _$$CallNotificationDataImplCopyWith<_$CallNotificationDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
