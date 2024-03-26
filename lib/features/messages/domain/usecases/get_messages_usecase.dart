import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

class GetMessagesUsecase
    implements
        BaseUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, String> {
  final MessagesRepository messagesRepository;

  GetMessagesUsecase({required this.messagesRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      String phoneNumber) {
    return messagesRepository.getMessages(phoneNumber: phoneNumber);
  }
}
