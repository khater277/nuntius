// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return _MessageModel.fromJson(json);
}

/// @nodoc
mixin _$MessageModel {
  @HiveField(0)
  String? get senderId => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get receiverId => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get message => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get messageId => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get date => throw _privateConstructorUsedError;
  @HiveField(5)
  bool? get isDeleted => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get media => throw _privateConstructorUsedError;
  @HiveField(7)
  bool? get isImage => throw _privateConstructorUsedError;
  @HiveField(8)
  bool? get isVideo => throw _privateConstructorUsedError;
  @HiveField(9)
  bool? get isDoc => throw _privateConstructorUsedError;
  @HiveField(10)
  bool? get isStoryReply => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get storyText => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get storyMedia => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get storyDate => throw _privateConstructorUsedError;
  @HiveField(14)
  bool? get isStoryImageReply => throw _privateConstructorUsedError;

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
          MessageModel value, $Res Function(MessageModel) then) =
      _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call(
      {@HiveField(0) String? senderId,
      @HiveField(1) String? receiverId,
      @HiveField(2) String? message,
      @HiveField(3) String? messageId,
      @HiveField(4) String? date,
      @HiveField(5) bool? isDeleted,
      @HiveField(6) String? media,
      @HiveField(7) bool? isImage,
      @HiveField(8) bool? isVideo,
      @HiveField(9) bool? isDoc,
      @HiveField(10) bool? isStoryReply,
      @HiveField(11) String? storyText,
      @HiveField(12) String? storyMedia,
      @HiveField(13) String? storyDate,
      @HiveField(14) bool? isStoryImageReply});
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? message = freezed,
    Object? messageId = freezed,
    Object? date = freezed,
    Object? isDeleted = freezed,
    Object? media = freezed,
    Object? isImage = freezed,
    Object? isVideo = freezed,
    Object? isDoc = freezed,
    Object? isStoryReply = freezed,
    Object? storyText = freezed,
    Object? storyMedia = freezed,
    Object? storyDate = freezed,
    Object? isStoryImageReply = freezed,
  }) {
    return _then(_value.copyWith(
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      isStoryReply: freezed == isStoryReply
          ? _value.isStoryReply
          : isStoryReply // ignore: cast_nullable_to_non_nullable
              as bool?,
      storyText: freezed == storyText
          ? _value.storyText
          : storyText // ignore: cast_nullable_to_non_nullable
              as String?,
      storyMedia: freezed == storyMedia
          ? _value.storyMedia
          : storyMedia // ignore: cast_nullable_to_non_nullable
              as String?,
      storyDate: freezed == storyDate
          ? _value.storyDate
          : storyDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isStoryImageReply: freezed == isStoryImageReply
          ? _value.isStoryImageReply
          : isStoryImageReply // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
          _$MessageModelImpl value, $Res Function(_$MessageModelImpl) then) =
      __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? senderId,
      @HiveField(1) String? receiverId,
      @HiveField(2) String? message,
      @HiveField(3) String? messageId,
      @HiveField(4) String? date,
      @HiveField(5) bool? isDeleted,
      @HiveField(6) String? media,
      @HiveField(7) bool? isImage,
      @HiveField(8) bool? isVideo,
      @HiveField(9) bool? isDoc,
      @HiveField(10) bool? isStoryReply,
      @HiveField(11) String? storyText,
      @HiveField(12) String? storyMedia,
      @HiveField(13) String? storyDate,
      @HiveField(14) bool? isStoryImageReply});
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
      _$MessageModelImpl _value, $Res Function(_$MessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderId = freezed,
    Object? receiverId = freezed,
    Object? message = freezed,
    Object? messageId = freezed,
    Object? date = freezed,
    Object? isDeleted = freezed,
    Object? media = freezed,
    Object? isImage = freezed,
    Object? isVideo = freezed,
    Object? isDoc = freezed,
    Object? isStoryReply = freezed,
    Object? storyText = freezed,
    Object? storyMedia = freezed,
    Object? storyDate = freezed,
    Object? isStoryImageReply = freezed,
  }) {
    return _then(_$MessageModelImpl(
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      isStoryReply: freezed == isStoryReply
          ? _value.isStoryReply
          : isStoryReply // ignore: cast_nullable_to_non_nullable
              as bool?,
      storyText: freezed == storyText
          ? _value.storyText
          : storyText // ignore: cast_nullable_to_non_nullable
              as String?,
      storyMedia: freezed == storyMedia
          ? _value.storyMedia
          : storyMedia // ignore: cast_nullable_to_non_nullable
              as String?,
      storyDate: freezed == storyDate
          ? _value.storyDate
          : storyDate // ignore: cast_nullable_to_non_nullable
              as String?,
      isStoryImageReply: freezed == isStoryImageReply
          ? _value.isStoryImageReply
          : isStoryImageReply // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageModelImpl implements _MessageModel {
  _$MessageModelImpl(
      {@HiveField(0) this.senderId,
      @HiveField(1) this.receiverId,
      @HiveField(2) this.message,
      @HiveField(3) this.messageId,
      @HiveField(4) this.date,
      @HiveField(5) this.isDeleted,
      @HiveField(6) this.media,
      @HiveField(7) this.isImage,
      @HiveField(8) this.isVideo,
      @HiveField(9) this.isDoc,
      @HiveField(10) this.isStoryReply,
      @HiveField(11) this.storyText,
      @HiveField(12) this.storyMedia,
      @HiveField(13) this.storyDate,
      @HiveField(14) this.isStoryImageReply});

  factory _$MessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageModelImplFromJson(json);

  @override
  @HiveField(0)
  final String? senderId;
  @override
  @HiveField(1)
  final String? receiverId;
  @override
  @HiveField(2)
  final String? message;
  @override
  @HiveField(3)
  final String? messageId;
  @override
  @HiveField(4)
  final String? date;
  @override
  @HiveField(5)
  final bool? isDeleted;
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
  final bool? isStoryReply;
  @override
  @HiveField(11)
  final String? storyText;
  @override
  @HiveField(12)
  final String? storyMedia;
  @override
  @HiveField(13)
  final String? storyDate;
  @override
  @HiveField(14)
  final bool? isStoryImageReply;

  @override
  String toString() {
    return 'MessageModel(senderId: $senderId, receiverId: $receiverId, message: $message, messageId: $messageId, date: $date, isDeleted: $isDeleted, media: $media, isImage: $isImage, isVideo: $isVideo, isDoc: $isDoc, isStoryReply: $isStoryReply, storyText: $storyText, storyMedia: $storyMedia, storyDate: $storyDate, isStoryImageReply: $isStoryImageReply)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.isImage, isImage) || other.isImage == isImage) &&
            (identical(other.isVideo, isVideo) || other.isVideo == isVideo) &&
            (identical(other.isDoc, isDoc) || other.isDoc == isDoc) &&
            (identical(other.isStoryReply, isStoryReply) ||
                other.isStoryReply == isStoryReply) &&
            (identical(other.storyText, storyText) ||
                other.storyText == storyText) &&
            (identical(other.storyMedia, storyMedia) ||
                other.storyMedia == storyMedia) &&
            (identical(other.storyDate, storyDate) ||
                other.storyDate == storyDate) &&
            (identical(other.isStoryImageReply, isStoryImageReply) ||
                other.isStoryImageReply == isStoryImageReply));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderId,
      receiverId,
      message,
      messageId,
      date,
      isDeleted,
      media,
      isImage,
      isVideo,
      isDoc,
      isStoryReply,
      storyText,
      storyMedia,
      storyDate,
      isStoryImageReply);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageModelImplToJson(
      this,
    );
  }
}

abstract class _MessageModel implements MessageModel {
  factory _MessageModel(
      {@HiveField(0) final String? senderId,
      @HiveField(1) final String? receiverId,
      @HiveField(2) final String? message,
      @HiveField(3) final String? messageId,
      @HiveField(4) final String? date,
      @HiveField(5) final bool? isDeleted,
      @HiveField(6) final String? media,
      @HiveField(7) final bool? isImage,
      @HiveField(8) final bool? isVideo,
      @HiveField(9) final bool? isDoc,
      @HiveField(10) final bool? isStoryReply,
      @HiveField(11) final String? storyText,
      @HiveField(12) final String? storyMedia,
      @HiveField(13) final String? storyDate,
      @HiveField(14) final bool? isStoryImageReply}) = _$MessageModelImpl;

  factory _MessageModel.fromJson(Map<String, dynamic> json) =
      _$MessageModelImpl.fromJson;

  @override
  @HiveField(0)
  String? get senderId;
  @override
  @HiveField(1)
  String? get receiverId;
  @override
  @HiveField(2)
  String? get message;
  @override
  @HiveField(3)
  String? get messageId;
  @override
  @HiveField(4)
  String? get date;
  @override
  @HiveField(5)
  bool? get isDeleted;
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
  bool? get isStoryReply;
  @override
  @HiveField(11)
  String? get storyText;
  @override
  @HiveField(12)
  String? get storyMedia;
  @override
  @HiveField(13)
  String? get storyDate;
  @override
  @HiveField(14)
  bool? get isStoryImageReply;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
