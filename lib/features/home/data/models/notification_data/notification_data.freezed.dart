// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return _NotificationData.fromJson(json);
}

/// @nodoc
mixin _$NotificationData {
  NotificationType get type => throw _privateConstructorUsedError;
  String get notificationId => throw _privateConstructorUsedError;
  String get notificationDate => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get senderID => throw _privateConstructorUsedError;
  String? get userToken => throw _privateConstructorUsedError;
  String? get senderName => throw _privateConstructorUsedError;
  String? get callId => throw _privateConstructorUsedError;
  CallType? get callType => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get channelName => throw _privateConstructorUsedError;
  @JsonKey(name: 'click_action')
  String? get clickAction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationDataCopyWith<NotificationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDataCopyWith<$Res> {
  factory $NotificationDataCopyWith(
          NotificationData value, $Res Function(NotificationData) then) =
      _$NotificationDataCopyWithImpl<$Res, NotificationData>;
  @useResult
  $Res call(
      {NotificationType type,
      String notificationId,
      String notificationDate,
      String phoneNumber,
      String senderID,
      String? userToken,
      String? senderName,
      String? callId,
      CallType? callType,
      String? token,
      String? channelName,
      @JsonKey(name: 'click_action') String? clickAction});
}

/// @nodoc
class _$NotificationDataCopyWithImpl<$Res, $Val extends NotificationData>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? notificationId = null,
    Object? notificationDate = null,
    Object? phoneNumber = null,
    Object? senderID = null,
    Object? userToken = freezed,
    Object? senderName = freezed,
    Object? callId = freezed,
    Object? callType = freezed,
    Object? token = freezed,
    Object? channelName = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationDate: null == notificationDate
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      senderID: null == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String,
      userToken: freezed == userToken
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String?,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: freezed == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String?,
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationDataImplCopyWith<$Res>
    implements $NotificationDataCopyWith<$Res> {
  factory _$$NotificationDataImplCopyWith(_$NotificationDataImpl value,
          $Res Function(_$NotificationDataImpl) then) =
      __$$NotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationType type,
      String notificationId,
      String notificationDate,
      String phoneNumber,
      String senderID,
      String? userToken,
      String? senderName,
      String? callId,
      CallType? callType,
      String? token,
      String? channelName,
      @JsonKey(name: 'click_action') String? clickAction});
}

/// @nodoc
class __$$NotificationDataImplCopyWithImpl<$Res>
    extends _$NotificationDataCopyWithImpl<$Res, _$NotificationDataImpl>
    implements _$$NotificationDataImplCopyWith<$Res> {
  __$$NotificationDataImplCopyWithImpl(_$NotificationDataImpl _value,
      $Res Function(_$NotificationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? notificationId = null,
    Object? notificationDate = null,
    Object? phoneNumber = null,
    Object? senderID = null,
    Object? userToken = freezed,
    Object? senderName = freezed,
    Object? callId = freezed,
    Object? callType = freezed,
    Object? token = freezed,
    Object? channelName = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_$NotificationDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationDate: null == notificationDate
          ? _value.notificationDate
          : notificationDate // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      senderID: null == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String,
      userToken: freezed == userToken
          ? _value.userToken
          : userToken // ignore: cast_nullable_to_non_nullable
              as String?,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      channelName: freezed == channelName
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
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
class _$NotificationDataImpl implements _NotificationData {
  _$NotificationDataImpl(
      {required this.type,
      required this.notificationId,
      required this.notificationDate,
      required this.phoneNumber,
      required this.senderID,
      this.userToken,
      this.senderName,
      this.callId,
      this.callType,
      this.token,
      this.channelName,
      @JsonKey(name: 'click_action') this.clickAction});

  factory _$NotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDataImplFromJson(json);

  @override
  final NotificationType type;
  @override
  final String notificationId;
  @override
  final String notificationDate;
  @override
  final String phoneNumber;
  @override
  final String senderID;
  @override
  final String? userToken;
  @override
  final String? senderName;
  @override
  final String? callId;
  @override
  final CallType? callType;
  @override
  final String? token;
  @override
  final String? channelName;
  @override
  @JsonKey(name: 'click_action')
  final String? clickAction;

  @override
  String toString() {
    return 'NotificationData(type: $type, notificationId: $notificationId, notificationDate: $notificationDate, phoneNumber: $phoneNumber, senderID: $senderID, userToken: $userToken, senderName: $senderName, callId: $callId, callType: $callType, token: $token, channelName: $channelName, clickAction: $clickAction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.notificationDate, notificationDate) ||
                other.notificationDate == notificationDate) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.senderID, senderID) ||
                other.senderID == senderID) &&
            (identical(other.userToken, userToken) ||
                other.userToken == userToken) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.clickAction, clickAction) ||
                other.clickAction == clickAction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      notificationId,
      notificationDate,
      phoneNumber,
      senderID,
      userToken,
      senderName,
      callId,
      callType,
      token,
      channelName,
      clickAction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      __$$NotificationDataImplCopyWithImpl<_$NotificationDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDataImplToJson(
      this,
    );
  }
}

abstract class _NotificationData implements NotificationData {
  factory _NotificationData(
          {required final NotificationType type,
          required final String notificationId,
          required final String notificationDate,
          required final String phoneNumber,
          required final String senderID,
          final String? userToken,
          final String? senderName,
          final String? callId,
          final CallType? callType,
          final String? token,
          final String? channelName,
          @JsonKey(name: 'click_action') final String? clickAction}) =
      _$NotificationDataImpl;

  factory _NotificationData.fromJson(Map<String, dynamic> json) =
      _$NotificationDataImpl.fromJson;

  @override
  NotificationType get type;
  @override
  String get notificationId;
  @override
  String get notificationDate;
  @override
  String get phoneNumber;
  @override
  String get senderID;
  @override
  String? get userToken;
  @override
  String? get senderName;
  @override
  String? get callId;
  @override
  CallType? get callType;
  @override
  String? get token;
  @override
  String? get channelName;
  @override
  @JsonKey(name: 'click_action')
  String? get clickAction;
  @override
  @JsonKey(ignore: true)
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
