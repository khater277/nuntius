import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_message_model.freezed.dart';
part 'last_message_model.g.dart';

@freezed
class LastMessageModel with _$LastMessageModel {
  factory LastMessageModel({
    String? token,
    String? image,
    String? senderID,
    String? receiverID,
    String? message,
    String? date,
    String? media,
    bool? isImage,
    bool? isVideo,
    bool? isDoc,
    bool? isDeleted,
    bool? isRead,
  }) = _LastMessageModel;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);
}
