import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'last_message_model.freezed.dart';
part 'last_message_model.g.dart';

@freezed
@HiveType(typeId: 3)
class LastMessageModel with _$LastMessageModel {
  factory LastMessageModel({
    @HiveField(0) String? token,
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
    @HiveField(11) bool? isRead,
  }) = _LastMessageModel;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);
}
