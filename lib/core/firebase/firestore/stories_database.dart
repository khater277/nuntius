import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuntius_/core/firebase/collections_keys.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius_/features/stories/data/models/story_model/story_model.dart';

abstract class StoriesDatabase {
  Future<void> sendStory({required StoryModel storyModel});
  Future<void> updateStory(
      {required StoryModel storyModel, required String phoneNumber});
  Future<void> deleteStory({required String storyId});

  Future<void> setLastStory({required StoryModel storyModel});
  Future<void> updateLastStory({required StoryModel storyModel});
  Future<void> deleteLastStory();

  Stream<QuerySnapshot<Map<String, dynamic>>> getStories();
  Stream<QuerySnapshot<Map<String, dynamic>>> getContactsLastStories();
  Future<List<ContactStoryModel>?> getContactsCurrentStories(
      {required List<UserData> users});
}

class StoriesDatabaseImpl implements StoriesDatabase {
  final UserStorage userStorage;

  StoriesDatabaseImpl({required this.userStorage});
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> sendStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
        .collection(Collections.currentStories)
        .doc(storyModel.id)
        .set(storyModel.toJson());
  }

  @override
  Future<void> updateStory(
      {required StoryModel storyModel, required String phoneNumber}) async {
    _db
        .collection(Collections.stories)
        .doc(phoneNumber)
        .collection(Collections.currentStories)
        .doc(storyModel.id)
        .update(storyModel.toJson());
  }

  @override
  Future<void> deleteStory({required String storyId}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
        .collection(Collections.currentStories)
        .doc(storyId)
        .delete();
  }

  @override
  Future<void> setLastStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
        .set(storyModel.toJson());
  }

  @override
  Future<void> updateLastStory({required StoryModel storyModel}) async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
        .update(storyModel.toJson());
  }

  @override
  Future<void> deleteLastStory() async {
    _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
        .delete();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getStories() {
    return _db
        .collection(Collections.stories)
        .doc(userStorage.getData()!.phone)
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
            if (storyModel.canView!.contains(userStorage.getData()!.phone)) {
              stories.add(storyModel);
              // print(
              //     "canView====>${storyModel.canView} ----- myPhone====>${userStorage.getData()!.phone}");
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
}
