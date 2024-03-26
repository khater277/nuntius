import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';

abstract class ChatsRepository {
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChats();
  Future<Either<Failure, void>> deleteChat({required String phoneNumber});
}
