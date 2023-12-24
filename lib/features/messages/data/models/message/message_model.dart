import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    String? senderId,
    String? receiverId,
    String? message,
    String? messageId,
    String? date,
    bool? isDeleted,
    String? media,
    bool? isImage,
    bool? isVideo,
    bool? isDoc,
    bool? isStoryReply,
    String? storyText,
    String? storyMedia,
    String? storyDate,
    bool? isStoryImageReply,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
