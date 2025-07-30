// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageNotificationData _$MessageNotificationDataFromJson(
    Map<String, dynamic> json) {
  return _MessageNotificationData.fromJson(json);
}

/// @nodoc
mixin _$MessageNotificationData {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get senderId => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'click_action')
  String? get clickAction => throw _privateConstructorUsedError;

  /// Serializes this MessageNotificationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageNotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageNotificationDataCopyWith<MessageNotificationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageNotificationDataCopyWith<$Res> {
  factory $MessageNotificationDataCopyWith(MessageNotificationData value,
          $Res Function(MessageNotificationData) then) =
      _$MessageNotificationDataCopyWithImpl<$Res, MessageNotificationData>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phoneNumber,
      String? senderId,
      String? type,
      @JsonKey(name: 'click_action') String? clickAction});
}

/// @nodoc
class _$MessageNotificationDataCopyWithImpl<$Res,
        $Val extends MessageNotificationData>
    implements $MessageNotificationDataCopyWith<$Res> {
  _$MessageNotificationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageNotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? senderId = freezed,
    Object? type = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageNotificationDataImplCopyWith<$Res>
    implements $MessageNotificationDataCopyWith<$Res> {
  factory _$$MessageNotificationDataImplCopyWith(
          _$MessageNotificationDataImpl value,
          $Res Function(_$MessageNotificationDataImpl) then) =
      __$$MessageNotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? phoneNumber,
      String? senderId,
      String? type,
      @JsonKey(name: 'click_action') String? clickAction});
}

/// @nodoc
class __$$MessageNotificationDataImplCopyWithImpl<$Res>
    extends _$MessageNotificationDataCopyWithImpl<$Res,
        _$MessageNotificationDataImpl>
    implements _$$MessageNotificationDataImplCopyWith<$Res> {
  __$$MessageNotificationDataImplCopyWithImpl(
      _$MessageNotificationDataImpl _value,
      $Res Function(_$MessageNotificationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageNotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? senderId = freezed,
    Object? type = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_$MessageNotificationDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageNotificationDataImpl implements _MessageNotificationData {
  _$MessageNotificationDataImpl(
      {this.id,
      this.name,
      this.phoneNumber,
      this.senderId,
      this.type,
      @JsonKey(name: 'click_action') this.clickAction});

  factory _$MessageNotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageNotificationDataImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? phoneNumber;
  @override
  final String? senderId;
  @override
  final String? type;
  @override
  @JsonKey(name: 'click_action')
  final String? clickAction;

  @override
  String toString() {
    return 'MessageNotificationData(id: $id, name: $name, phoneNumber: $phoneNumber, senderId: $senderId, type: $type, clickAction: $clickAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageNotificationDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.clickAction, clickAction) ||
                other.clickAction == clickAction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, phoneNumber, senderId, type, clickAction);

  /// Create a copy of MessageNotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageNotificationDataImplCopyWith<_$MessageNotificationDataImpl>
      get copyWith => __$$MessageNotificationDataImplCopyWithImpl<
          _$MessageNotificationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageNotificationDataImplToJson(
      this,
    );
  }
}

abstract class _MessageNotificationData implements MessageNotificationData {
  factory _MessageNotificationData(
          {final String? id,
          final String? name,
          final String? phoneNumber,
          final String? senderId,
          final String? type,
          @JsonKey(name: 'click_action') final String? clickAction}) =
      _$MessageNotificationDataImpl;

  factory _MessageNotificationData.fromJson(Map<String, dynamic> json) =
      _$MessageNotificationDataImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get phoneNumber;
  @override
  String? get senderId;
  @override
  String? get type;
  @override
  @JsonKey(name: 'click_action')
  String? get clickAction;

  /// Create a copy of MessageNotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageNotificationDataImplCopyWith<_$MessageNotificationDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
