import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';

class SendMessageParams {
  final String phoneNumber;
  final LastMessageModel lastMessageModel;
  final MessageModel messageModel;

  SendMessageParams(
      {required this.phoneNumber,
      required this.lastMessageModel,
      required this.messageModel});
}
