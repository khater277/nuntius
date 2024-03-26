import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/domain/parameters/update_story_params.dart';

abstract class StoriesDatabase {
  Future<void> sendStory({required StoryModel storyModel});
  Future<void> updateStory({required UpdateStoryParams updateStoryParams});
  Future<void> deleteStory({required String storyId});

  Future<void> setLastStory({required StoryModel storyModel});
  Future<void> updateLastStory({required StoryModel storyModel});
  Future<void> deleteLastStory();

  Stream<QuerySnapshot<Map<String, dynamic>>> getStories();
  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsLastStories();
  Future<List<ContactStoryModel>?> getContactsCurrentStories(
      {required List<UserData> users});

  Future<void> deleteAllStories();
}

class StoriesDatabaseImpl implements StoriesDatabase {
  final UserStorage userStorage;

  StoriesDatabaseImpl({required this.userStorage});
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> sendStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.currentStories)
        .doc(storyModel.id)
        .set(storyModel.toJson());
  }

  @override
  Future<void> updateStory(
      {required UpdateStoryParams updateStoryParams}) async {
    _db
        .collection(Collections.stories)
        .doc(updateStoryParams.phoneNumber)
        .collection(Collections.currentStories)
        .doc(updateStoryParams.storyModel.id)
        .update(updateStoryParams.storyModel.toJson());
  }

  @override
  Future<void> deleteStory({required String storyId}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.currentStories)
        .doc(storyId)
        .delete();
  }

  @override
  Future<void> setLastStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .set(storyModel.toJson());
  }

  @override
  Future<void> updateLastStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .update(storyModel.toJson());
  }

  @override
  Future<void> deleteLastStory() async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .delete();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStories() {
    return _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.currentStories)
        .orderBy('date')
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsLastStories() {
    return _db
        .collection(Collections.stories)
        .orderBy('date', descending: true)
        .snapshots();
  }

  @override
  Future<List<ContactStoryModel>?> getContactsCurrentStories(
      {required List<UserData> users}) async {
    try {
      List<ContactStoryModel> contactsStories = [];
      for (int i = 0; i < users.length; i++) {
        List<StoryModel> stories = [];
        final response = await _db
            .collection(Collections.stories)
            .doc(users[i].phone)
            .collection(Collections.currentStories)
            .orderBy('date')
            .get();

        final docs = response.docs;
        if (docs.isNotEmpty) {
          for (var element in docs) {
            final storyModel = StoryModel.fromJson(element.data());
            // print("=============>${storyModel.toString()}");
            if (storyModel.canView!.contains(userStorage.getUser()!.phone)) {
              stories.add(storyModel);
              // print(
              //     "canView====>${storyModel.canView} ----- myPhone====>${userStorage.getUser()!.phone}");
            }
          }
        }
        final contactStoryModel = ContactStoryModel(
          user: users[i],
          stories: stories,
        );
        if (contactStoryModel.stories != null &&
            contactStoryModel.stories!.isNotEmpty) {
          contactsStories.add(
            ContactStoryModel(
              user: users[i],
              stories: stories,
            ),
          );
        }
      }
      return contactsStories;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> deleteAllStories() async {
    final stories = await _db
        .collection(Collections.stories)
        .doc(userStorage.getUser()!.phone)
        .collection(Collections.currentStories)
        .get();
    for (var element in stories.docs) {
      final story = StoryModel.fromJson(element.data());
      await deleteStory(storyId: story.id!);
    }
    await deleteLastStory();
  }
}
