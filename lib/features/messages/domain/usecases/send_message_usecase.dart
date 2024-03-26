import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

class SendMessageUsecase implements BaseUseCase<void, SendMessageParams> {
  final MessagesRepository messagesRepository;

  SendMessageUsecase({required this.messagesRepository});

  @override
  Future<Either<Failure, void>> call(SendMessageParams sendMessageParams) {
    return messagesRepository.sendMessage(sendMessageParams: sendMessageParams);
  }
}
