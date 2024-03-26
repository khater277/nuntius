import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';

part 'chats_model.freezed.dart';
part 'chats_model.g.dart';

@freezed
@HiveType(typeId: 2)
class ChatsModel with _$ChatsModel {
  factory ChatsModel({
    @HiveField(0) UserData? user,
    @HiveField(1) LastMessageModel? lastMessage,
    @HiveField(2) List<MessageModel>? messages,
  }) = _ChatsModel;

  factory ChatsModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsModelFromJson(json);
}
