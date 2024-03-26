// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatsModel _$ChatsModelFromJson(Map<String, dynamic> json) {
  return _ChatsModel.fromJson(json);
}

/// @nodoc
mixin _$ChatsModel {
  @HiveField(0)
  UserData? get user => throw _privateConstructorUsedError;
  @HiveField(1)
  LastMessageModel? get lastMessage => throw _privateConstructorUsedError;
  @HiveField(2)
  List<MessageModel>? get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatsModelCopyWith<ChatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsModelCopyWith<$Res> {
  factory $ChatsModelCopyWith(
          ChatsModel value, $Res Function(ChatsModel) then) =
      _$ChatsModelCopyWithImpl<$Res, ChatsModel>;
  @useResult
  $Res call(
      {@HiveField(0) UserData? user,
      @HiveField(1) LastMessageModel? lastMessage,
      @HiveField(2) List<MessageModel>? messages});

  $UserDataCopyWith<$Res>? get user;
  $LastMessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatsModelCopyWithImpl<$Res, $Val extends ChatsModel>
    implements $ChatsModelCopyWith<$Res> {
  _$ChatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? lastMessage = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageModel?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDataCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LastMessageModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $LastMessageModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatsModelImplCopyWith<$Res>
    implements $ChatsModelCopyWith<$Res> {
  factory _$$ChatsModelImplCopyWith(
          _$ChatsModelImpl value, $Res Function(_$ChatsModelImpl) then) =
      __$$ChatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) UserData? user,
      @HiveField(1) LastMessageModel? lastMessage,
      @HiveField(2) List<MessageModel>? messages});

  @override
  $UserDataCopyWith<$Res>? get user;
  @override
  $LastMessageModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatsModelImplCopyWithImpl<$Res>
    extends _$ChatsModelCopyWithImpl<$Res, _$ChatsModelImpl>
    implements _$$ChatsModelImplCopyWith<$Res> {
  __$$ChatsModelImplCopyWithImpl(
      _$ChatsModelImpl _value, $Res Function(_$ChatsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
    Object? lastMessage = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$ChatsModelImpl(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessageModel?,
      messages: freezed == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatsModelImpl implements _ChatsModel {
  _$ChatsModelImpl(
      {@HiveField(0) this.user,
      @HiveField(1) this.lastMessage,
      @HiveField(2) final List<MessageModel>? messages})
      : _messages = messages;

  factory _$ChatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatsModelImplFromJson(json);

  @override
  @HiveField(0)
  final UserData? user;
  @override
  @HiveField(1)
  final LastMessageModel? lastMessage;
  final List<MessageModel>? _messages;
  @override
  @HiveField(2)
  List<MessageModel>? get messages {
    final value = _messages;
    if (value == null) return null;
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatsModel(user: $user, lastMessage: $lastMessage, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatsModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, lastMessage,
      const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatsModelImplCopyWith<_$ChatsModelImpl> get copyWith =>
      __$$ChatsModelImplCopyWithImpl<_$ChatsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatsModelImplToJson(
      this,
    );
  }
}

abstract class _ChatsModel implements ChatsModel {
  factory _ChatsModel(
      {@HiveField(0) final UserData? user,
      @HiveField(1) final LastMessageModel? lastMessage,
      @HiveField(2) final List<MessageModel>? messages}) = _$ChatsModelImpl;

  factory _ChatsModel.fromJson(Map<String, dynamic> json) =
      _$ChatsModelImpl.fromJson;

  @override
  @HiveField(0)
  UserData? get user;
  @override
  @HiveField(1)
  LastMessageModel? get lastMessage;
  @override
  @HiveField(2)
  List<MessageModel>? get messages;
  @override
  @JsonKey(ignore: true)
  _$$ChatsModelImplCopyWith<_$ChatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
