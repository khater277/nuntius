import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

class DeleteMessageUsecase implements BaseUseCase<void, DeleteMessageParams> {
  final MessagesRepository messagesRepository;

  DeleteMessageUsecase({required this.messagesRepository});

  @override
  Future<Either<Failure, void>> call(DeleteMessageParams deleteMessageParams) {
    return messagesRepository.deleteMessage(
        deleteMessageParams: deleteMessageParams);
  }
}
