import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/chats/domain/repositories/chats_repository.dart';

class DeleteChatUsecase implements BaseUseCase<void, String> {
  final ChatsRepository _chatsRepository;

  DeleteChatUsecase({required ChatsRepository chatsRepository})
      : _chatsRepository = chatsRepository;
  @override
  Future<Either<Failure, void>> call(String phoneNumber) {
    return _chatsRepository.deleteChat(phoneNumber: phoneNumber);
  }
}
