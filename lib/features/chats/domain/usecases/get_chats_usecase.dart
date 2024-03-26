// Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
//       getChats();

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/chats/domain/repositories/chats_repository.dart';

class GetChatsUsecase
    implements
        BaseUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final ChatsRepository chatsRepository;

  GetChatsUsecase({required this.chatsRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams params) {
    return chatsRepository.getChats();
  }
}
