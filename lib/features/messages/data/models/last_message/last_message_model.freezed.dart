// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) {
  return _LastMessageModel.fromJson(json);
}

/// @nodoc
mixin _$LastMessageModel {
  @HiveField(0)
  String? get token => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get senderID => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get receiverID => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get message => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get date => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get media => throw _privateConstructorUsedError;
  @HiveField(7)
  bool? get isImage => throw _privateConstructorUsedError;
  @HiveField(8)
  bool? get isVideo => throw _privateConstructorUsedError;
  @HiveField(9)
  bool? get isDoc => throw _privateConstructorUsedError;
  @HiveField(10)
  bool? get isDeleted => throw _privateConstructorUsedError;
  @HiveField(11)
  bool? get isRead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LastMessageModelCopyWith<LastMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageModelCopyWith<$Res> {
  factory $LastMessageModelCopyWith(
          LastMessageModel value, $Res Function(LastMessageModel) then) =
      _$LastMessageModelCopyWithImpl<$Res, LastMessageModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? token,
      @HiveField(1) String? image,
      @HiveField(2) String? senderID,
      @HiveField(3) String? receiverID,
      @HiveField(4) String? message,
      @HiveField(5) String? date,
      @HiveField(6) String? media,
      @HiveField(7) bool? isImage,
      @HiveField(8) bool? isVideo,
      @HiveField(9) bool? isDoc,
      @HiveField(10) bool? isDeleted,
      @HiveField(11) bool? isRead});
}

/// @nodoc
class _$LastMessageModelCopyWithImpl<$Res, $Val extends LastMessageModel>
    implements $LastMessageModelCopyWith<$Res> {
  _$LastMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? image = freezed,
    Object? senderID = freezed,
    Object? receiverID = freezed,
    Object? message = freezed,
    Object? date = freezed,
    Object? media = freezed,
    Object? isImage = freezed,
    Object? isVideo = freezed,
    Object? isDoc = freezed,
    Object? isDeleted = freezed,
    Object? isRead = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      senderID: freezed == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverID: freezed == receiverID
          ? _value.receiverID
          : receiverID // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      isImage: freezed == isImage
          ? _value.isImage
          : isImage // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDoc: freezed == isDoc
          ? _value.isDoc
          : isDoc // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastMessageModelImplCopyWith<$Res>
    implements $LastMessageModelCopyWith<$Res> {
  factory _$$LastMessageModelImplCopyWith(_$LastMessageModelImpl value,
          $Res Function(_$LastMessageModelImpl) then) =
      __$$LastMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? token,
      @HiveField(1) String? image,
      @HiveField(2) String? senderID,
      @HiveField(3) String? receiverID,
      @HiveField(4) String? message,
      @HiveField(5) String? date,
      @HiveField(6) String? media,
      @HiveField(7) bool? isImage,
      @HiveField(8) bool? isVideo,
      @HiveField(9) bool? isDoc,
      @HiveField(10) bool? isDeleted,
      @HiveField(11) bool? isRead});
}

/// @nodoc
class __$$LastMessageModelImplCopyWithImpl<$Res>
    extends _$LastMessageModelCopyWithImpl<$Res, _$LastMessageModelImpl>
    implements _$$LastMessageModelImplCopyWith<$Res> {
  __$$LastMessageModelImplCopyWithImpl(_$LastMessageModelImpl _value,
      $Res Function(_$LastMessageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? image = freezed,
    Object? senderID = freezed,
    Object? receiverID = freezed,
    Object? message = freezed,
    Object? date = freezed,
    Object? media = freezed,
    Object? isImage = freezed,
    Object? isVideo = freezed,
    Object? isDoc = freezed,
    Object? isDeleted = freezed,
    Object? isRead = freezed,
  }) {
    return _then(_$LastMessageModelImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      senderID: freezed == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverID: freezed == receiverID
          ? _value.receiverID
          : receiverID // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      isImage: freezed == isImage
          ? _value.isImage
          : isImage // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVideo: freezed == isVideo
          ? _value.isVideo
          : isVideo // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDoc: freezed == isDoc
          ? _value.isDoc
          : isDoc // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageModelImpl implements _LastMessageModel {
  _$LastMessageModelImpl(
      {@HiveField(0) this.token,
      @HiveField(1) this.image,
      @HiveField(2) this.senderID,
      @HiveField(3) this.receiverID,
      @HiveField(4) this.message,
      @HiveField(5) this.date,
      @HiveField(6) this.media,
      @HiveField(7) this.isImage,
      @HiveField(8) this.isVideo,
      @HiveField(9) this.isDoc,
      @HiveField(10) this.isDeleted,
      @HiveField(11) this.isRead});

  factory _$LastMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? token;
  @override
  @HiveField(1)
  final String? image;
  @override
  @HiveField(2)
  final String? senderID;
  @override
  @HiveField(3)
  final String? receiverID;
  @override
  @HiveField(4)
  final String? message;
  @override
  @HiveField(5)
  final String? date;
  @override
  @HiveField(6)
  final String? media;
  @override
  @HiveField(7)
  final bool? isImage;
  @override
  @HiveField(8)
  final bool? isVideo;
  @override
  @HiveField(9)
  final bool? isDoc;
  @override
  @HiveField(10)
  final bool? isDeleted;
  @override
  @HiveField(11)
  final bool? isRead;

  @override
  String toString() {
    return 'LastMessageModel(token: $token, image: $image, senderID: $senderID, receiverID: $receiverID, message: $message, date: $date, media: $media, isImage: $isImage, isVideo: $isVideo, isDoc: $isDoc, isDeleted: $isDeleted, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageModelImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.senderID, senderID) ||
                other.senderID == senderID) &&
            (identical(other.receiverID, receiverID) ||
                other.receiverID == receiverID) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.isImage, isImage) || other.isImage == isImage) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.isDoc, isDoc) || other.isDoc == isDoc) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      token,
      image,
      senderID,
      receiverID,
      message,
      date,
      media,
      isImage,
      isVideo,
      isDoc,
      isDeleted,
      isRead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      __$$LastMessageModelImplCopyWithImpl<_$LastMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageModelImplToJson(
      this,
    );
  }
}

abstract class _LastMessageModel implements LastMessageModel {
  factory _LastMessageModel(
      {@HiveField(0) final String? token,
      @HiveField(1) final String? image,
      @HiveField(2) final String? senderID,
      @HiveField(3) final String? receiverID,
      @HiveField(4) final String? message,
      @HiveField(5) final String? date,
      @HiveField(6) final String? media,
      @HiveField(7) final bool? isImage,
      @HiveField(8) final bool? isVideo,
      @HiveField(9) final bool? isDoc,
      @HiveField(10) final bool? isDeleted,
      @HiveField(11) final bool? isRead}) = _$LastMessageModelImpl;

  factory _LastMessageModel.fromJson(Map<String, dynamic> json) =
      _$LastMessageModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get token;
  @override
  @HiveField(1)
  String? get image;
  @override
  @HiveField(2)
  String? get senderID;
  @override
  @HiveField(3)
  String? get receiverID;
  @override
  @HiveField(4)
  String? get message;
  @override
  @HiveField(5)
  String? get date;
  @override
  @HiveField(6)
  String? get media;
  @override
  @HiveField(7)
  bool? get isImage;
  @override
  @HiveField(8)
  bool? get isVideo;
  @override
  @HiveField(9)
  bool? get isDoc;
  @override
  @HiveField(10)
  bool? get isDeleted;
  @override
  @HiveField(11)
  bool? get isRead;
  @override
  @JsonKey(ignore: true)
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
