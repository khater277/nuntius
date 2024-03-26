import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/chats/data/datasources/chats_remote_data_source.dart';
import 'package:nuntius/features/chats/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDataSource chatsRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl(
      {required this.chatsRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChats() async {
    try {
      final response = chatsRemoteDataSource.getChats();
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }
}
