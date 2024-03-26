import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

class GetUserStreamUsecase
    implements
        BaseUseCase<Stream<DocumentSnapshot<Map<String, dynamic>>>, String> {
  final MessagesRepository messagesRepository;

  GetUserStreamUsecase({required this.messagesRepository});
  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> call(
      String phoneNumber) {
    return messagesRepository.getUserStream(phoneNumber: phoneNumber);
  }
}
