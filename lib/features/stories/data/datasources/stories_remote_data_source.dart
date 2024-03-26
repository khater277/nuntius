import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/firestore/stories_database.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/domain/parameters/update_story_params.dart';

abstract class StoriesRemoteDataSource {
  Future<void> setLastStory({required StoryModel storyModel});
  Future<void> sendStory({required StoryModel storyModel});
  Stream<QuerySnapshot<Map<String, dynamic>>> getStories();
  Future<void> deleteStory({required String storyId});
  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsLastStories();
  Future<List<ContactStoryModel>?> getContactsCurrentStories(
      {required List<UserData> users});
  Future<void> updateLastStory({required StoryModel storyModel});
  Future<void> deleteLastStory();
  Future<void> updateStory({required UpdateStoryParams updateStoryParams});
}

class StoriesRemoteDataSourceImpl implements StoriesRemoteDataSource {
  final StoriesDatabase storiesDatabase;

  StoriesRemoteDataSourceImpl({required this.storiesDatabase});
  @override
  Future<void> sendStory({required StoryModel storyModel}) {
    return storiesDatabase.sendStory(storyModel: storyModel);
  }

  @override
  Future<void> setLastStory({required StoryModel storyModel}) {
    return storiesDatabase.setLastStory(storyModel: storyModel);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStories() {
    return storiesDatabase.getStories();
  }

  @override
  Future<void> deleteStory({required String storyId}) {
    return storiesDatabase.deleteStory(storyId: storyId);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsLastStories() {
    return storiesDatabase.getContactsLastStories();
  }

  @override
  Future<List<ContactStoryModel>?> getContactsCurrentStories(
      {required List<UserData> users}) {
    return storiesDatabase.getContactsCurrentStories(users: users);
  }

  @override
  Future<void> updateLastStory({required StoryModel storyModel}) {
    return storiesDatabase.updateLastStory(storyModel: storyModel);
  }

  @override
  Future<void> deleteLastStory() {
    return storiesDatabase.deleteLastStory();
  }

  @override
  Future<void> updateStory({required UpdateStoryParams updateStoryParams}) {
    return storiesDatabase.updateStory(updateStoryParams: updateStoryParams);
  }
}
