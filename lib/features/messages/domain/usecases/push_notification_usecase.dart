import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';

class PushNotificationUsecase
    implements BaseUseCase<String, Map<String, dynamic>> {
  final MessagesRepository messagesRepository;

  PushNotificationUsecase({required this.messagesRepository});

  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> fcmBody) {
    return messagesRepository.pushNotification(fcmBody: fcmBody);
  }
}
