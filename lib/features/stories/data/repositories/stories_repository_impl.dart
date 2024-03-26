import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:nuntius/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/domain/parameters/update_story_params.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDataSource storiesRemoteDataSource;
  final NetworkInfo networkInfo;

  StoriesRepositoryImpl({
    required this.storiesRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, void>> sendStory(
      {required StoryModel storyModel}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            storiesRemoteDataSource.sendStory(storyModel: storyModel);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> setLastStory(
      {required StoryModel storyModel}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            storiesRemoteDataSource.setLastStory(storyModel: storyModel);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getStories() async {
    try {
      final response = storiesRemoteDataSource.getStories();
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStory({required String storyId}) async {
    if (await networkInfo.connected()) {
      try {
        final response =
            await storiesRemoteDataSource.deleteStory(storyId: storyId);
        return Right(response);
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getContactsLastStories() async {
    try {
      final response = storiesRemoteDataSource.getContactsLastStories();
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, List<ContactStoryModel>?>> getContactsCurrentStories(
      {required List<UserData> users}) async {
    if (await networkInfo.connected()) {
      try {
        final response = await storiesRemoteDataSource
            .getContactsCurrentStories(users: users);
        if (response != null) {
          return Right(response);
        } else {
          FirebaseAuthException exception =
              FirebaseAuthException(code: 'not-found');
          return Left(ServerFailure(
              error: exception, type: NetworkErrorTypes.firestore));
        }
      } on FirebaseException catch (error) {
        return Left(
            ServerFailure(error: error, type: NetworkErrorTypes.firestore));
      }
    } else {
      return Left(ServerFailure(
        error: NoInternetConnection(),
        type: NetworkErrorTypes.noInternetConnection,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastStory(
      {required StoryModel storyModel}) async {
    try {
      final response =
          storiesRemoteDataSource.updateLastStory(storyModel: storyModel);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLastStory() async {
    try {
      final response = storiesRemoteDataSource.deleteLastStory();
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }

  @override
  Future<Either<Failure, void>> updateStory(
      {required UpdateStoryParams updateStoryParams}) async {
    try {
      final response = storiesRemoteDataSource.updateStory(
          updateStoryParams: updateStoryParams);
      return Right(response);
    } on FirebaseException catch (error) {
      return Left(
          ServerFailure(error: error, type: NetworkErrorTypes.firestore));
    }
  }
}
