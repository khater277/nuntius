import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
@HiveType(typeId: 4)
class MessageModel with _$MessageModel {
  factory MessageModel({
    @HiveField(0) String? senderId,
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
    @HiveField(14) bool? isStoryImageReply,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
