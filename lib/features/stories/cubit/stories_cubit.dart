import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';
import 'package:nuntius/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/send_message_usecase.dart';
import 'package:nuntius/features/stories/data/models/contact_story_model/contact_story_model.dart';
import 'package:nuntius/features/stories/data/models/story_model/story_model.dart';
import 'package:nuntius/features/stories/data/models/viewer_model/viewer_model.dart';
import 'package:nuntius/features/stories/domain/parameters/update_story_params.dart';
import 'package:nuntius/features/stories/domain/usecases/delete_last_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/delete_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_contacts_current_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_contacts_last_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/send_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/set_last_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/update_story_usecase.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/my_story_viewers/viewers_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_view/story_view.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'stories_cubit.freezed.dart';
part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final SendStoryUsecase _sendStoryUsecase;
  final DeleteStoryUsecase _deleteStoryUsecase;
  final UpdateStoryUsecase _updateStoryUsecase;
  final GetStoriesUsecase _getStoriesUsecase;
  final SetLastStoryUsecase _setLastStoryUsecase;
  final DeleteLastStoryUsecase _deleteLastStoryUsecase;
  final GetContactsCurrentStoriesUsecase _getContactsCurrentStoriesUsecase;
  final GetContactsLastStoriesUsecase _getContactsLastStoriesUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final UploadFileToStorageUsecase _uploadFileToStorageUsecase;
  final PushNotificationUsecase _pushNotificationUsecase;
  final UserStorage _userStorage;

  StoriesCubit({
    required SendStoryUsecase sendStoryUsecase,
    required DeleteStoryUsecase deleteStoryUsecase,
    required UpdateStoryUsecase updateStoryUsecase,
    required GetStoriesUsecase getStoriesUsecase,
    required SetLastStoryUsecase setLastStoryUsecase,
    required DeleteLastStoryUsecase deleteLastStoryUsecase,
    required GetContactsCurrentStoriesUsecase getContactsCurrentStoriesUsecase,
    required GetContactsLastStoriesUsecase getContactsLastStoriesUsecase,
    required SendMessageUsecase sendMessageUsecase,
    required UploadFileToStorageUsecase uploadFileToStorageUsecase,
    required PushNotificationUsecase pushNotificationUsecase,
    required UserStorage userStorage,
  })  : _sendStoryUsecase = sendStoryUsecase,
        _deleteStoryUsecase = deleteStoryUsecase,
        _updateStoryUsecase = updateStoryUsecase,
        _getStoriesUsecase = getStoriesUsecase,
        _setLastStoryUsecase = setLastStoryUsecase,
        _deleteLastStoryUsecase = deleteLastStoryUsecase,
        _getContactsCurrentStoriesUsecase = getContactsCurrentStoriesUsecase,
        _getContactsLastStoriesUsecase = getContactsLastStoriesUsecase,
        _sendMessageUsecase = sendMessageUsecase,
        _uploadFileToStorageUsecase = uploadFileToStorageUsecase,
        _pushNotificationUsecase = pushNotificationUsecase,
        _userStorage = userStorage,
        super(const StoriesState.initial());

  TextEditingController? storyTextController;
  void initAddTextStory() {
    storyTextController = TextEditingController();
    emit(const StoriesState.initAddTextStory());
  }

  void disposeAddTextStory() {
    storyTextController!.dispose();
    storyFile = null;
    emit(const StoriesState.disposeAddTextStory());
  }

  ImagePicker picker = ImagePicker();
  double filePercentage = 0.0;
  File? storyFile;
  double width = 0.0;
  double height = 0.0;

  Future<void> pickStoryMedia({required MessageType type}) async {
    emit(StoriesState.pickStoryMediaLoading(type));
    final pickedFile = type == MessageType.image
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      storyFile = File(pickedFile.path);
      if (type == MessageType.image) {
        final image = await decodeImageFromList(storyFile!.readAsBytesSync());
        width = image.width.roundToDouble();
        height = image.height.roundToDouble();
      }
      emit(const StoriesState.pickStoryMedia());
    } else {
      debugPrint("NOT SELECTED");
      emit(const StoriesState.pickStoryMediaError());
    }
  }

  String? videoDuration;

  void setVideoDuration(String duration) {
    videoDuration = duration;
    emit(const StoriesState.setVideoDuration());
  }

  void sendStory({String? media, MessageType? mediaType}) async {
    emit(const StoriesState.sendStoryLoading());

    final storyModel = StoryModel(
      id: const Uuid().v4(),
      date: DateTime.now().toUtc().toString(),
      validateTo:
          DateTime.now().toUtc().add(const Duration(hours: 24)).toString(),
      isImage: mediaType == MessageType.image ? true : false,
      isVideo: mediaType == MessageType.video ? true : false,
      isRead: false,
      videoDuration: videoDuration,
      media: media ?? "",
      phone: _userStorage.getUser()!.phone,
      text: storyTextController!.text,
      viewers: [],
      viewersPhones: [],
      canView: di<HomeCubit>().phones.keys.toList(),
    );
    debugPrint("=================>${di<HomeCubit>().phones}");
    final response = await _setLastStoryUsecase.call(storyModel);

    response.fold(
      (failure) => emit(StoriesState.sendStoryError(failure.getMessage())),
      (result) async {
        final response = await _sendStoryUsecase.call(storyModel);
        response.fold(
          (failure) => emit(StoriesState.sendStoryError(failure.getMessage())),
          (result) {
            storyTextController!.clear();
            width = 0.0;
            height = 0.0;
            emit(const StoriesState.sendStory());
          },
        );
      },
    );
  }

  void sendMediaStory({required MessageType mediaType}) async {
    emit(const StoriesState.sendStoryLoading());
    final response = await _uploadFileToStorageUsecase.call(
        UploadFileToStorageParams(
            collectionName: Collections.messageImages, file: storyFile!));
    response.fold(
      (failure) {
        emit(StoriesState.sendStoryError(failure.getMessage()));
      },
      (result) {
        result!.fold(
          (url) => sendStory(media: url, mediaType: mediaType),
          (taskSnapshot) {
            taskSnapshot.listen((event) async {
              switch (event.state) {
                case TaskState.running:
                  filePercentage = event.bytesTransferred / event.totalBytes;
                  emit(StoriesState.getFilePercentage(filePercentage));
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  final url = await event.ref.getDownloadURL();
                  sendStory(media: url, mediaType: mediaType);
                  break;
                case TaskState.canceled:
                  emit(const StoriesState.sendStoryError(
                      "The operation has been cancelled."));
                  break;
                case TaskState.error:
                  emit(const StoriesState.sendStoryError(
                      "The operation has been failed."));
                  break;
              }
            });
          },
        );
      },
    );
  }

  List<StoryModel> myStories = [];
  bool stopLoading = false;
  void cancelLoading() {
    stopLoading = true;
    emit(const StoriesState.initAddTextStory());
  }

  Future<void> executeAsyncFunctions() async {
    await getMyStories();
    await getContactsStories();
  }

  Future<void> getMyStories() async {
    // emit(const StoriesState.getMyStoriesLoading());
    emit(const StoriesState.testLoading());
    final response = await _getStoriesUsecase.call(NoParams());
    response.fold(
      (failure) => emit(StoriesState.testError(failure.getMessage())),
      // emit(StoriesState.getMyStoriesError(failure.getMessage())),
      (snapshots) {
        snapshots.listen((event) {
          List<StoryModel> myStories = [];
          for (var doc in event.docs) {
            final story = StoryModel.fromJson(doc.data());
            if (DateTime.now()
                .toUtc()
                .isBefore(DateTime.parse(story.validateTo!))) {
              myStories.add(story);
            }
          }
          this.myStories = myStories;
          emit(StoriesState.getMyStories(myStories));
        });
      },
    );
  }

  StoryController? storyController;
  List<StoryItem> storyItems = [];

  void initStoryView({
    required List<StoryModel> stories,
    bool isDeleted = false,
  }) {
    storyController = StoryController();
    storyItems = [];
    handleStoryItems(stories: stories);
    emit(const StoriesState.initStoryView());
  }

  void disposeStoryView() {
    storyController!.dispose();
    storyIndex = 0;
    emit(const StoriesState.disposeStoryView());
  }

  void handleStoryItems({required List<StoryModel> stories}) {
    for (int i = 0; i < stories.length; i++) {
      if (stories[i].media != "") {
        if (stories[i].isImage == true) {
          storyItems.add(StoryItem.pageImage(
            url: stories[i].media!,
            controller: storyController!,
            caption: Text(stories[i].text ?? ""),
          ));
        } else {
          storyItems.add(StoryItem.pageVideo(
            stories[i].media!,
            controller: storyController!,
            duration: AppFunctions.durationParser(
                duration: stories[i].videoDuration!),
            caption: Text(stories[i].text ?? ""),
          ));
        }
      } else {
        storyItems.add(StoryItem.text(
          title: stories[i].text!,
          backgroundColor: AppColors.black,
        ));
      }
    }
  }

  int storyIndex = 0;
  void changeStoryIndex({required int index}) {
    storyIndex = index;
    // if (index == 0 && isDeleted == true) {
    //   debugPrint("A7A");
    // }
    // debugPrint("==================>$index ${myStories.length}");
    emit(StoriesState.changeStoryIndex(index));
  }

  void resetStoryIndex() {
    storyIndex = 0;
    emit(const StoriesState.resetStoryIndex());
  }

  void showStoryViewers({
    required BuildContext context,
    required List<Map<String, dynamic>> viewers,
  }) {
    storyController!.pause();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        List<UserData> users = [];
        List<String> viewsDateTime = [];
        for (var viewer in viewers) {
          final viewerModel = ViewerModel.fromJson(viewer);
          UserData userData = di<HomeCubit>().users.firstWhereOrNull(
                  (element) => element.uId == viewerModel.id) ??
              UserData(
                uId: viewerModel.id,
                name: viewerModel.phoneNumber,
                phone: viewerModel.phoneNumber,
                image: "",
              );
          users.add(userData);
          viewsDateTime.add(viewerModel.dateTime!);
        }
        return ViewersBottomSheet(
          users: users,
          viewsDateTime: viewsDateTime,
        );
      },
    ).then((value) => storyController!.play());
  }

  void deleteStory({required String storyId}) async {
    emit(StoriesState.deleteStoryLoading(storyId));
    final response = await _deleteStoryUsecase.call(storyId);
    response.fold(
      (failure) => emit(StoriesState.deleteStoryError(failure.getMessage())),
      (result) async {
        final story = myStories.firstWhere((element) => element.id == storyId);
        // myStories.removeWhere((element) => element.id == storyId);
        if (story == myStories.last) {
          myStories.removeLast();
          if (myStories.isNotEmpty) {
            final response = await _setLastStoryUsecase.call(myStories.last);
            response.fold(
              (failure) =>
                  emit(StoriesState.deleteStoryError(failure.getMessage())),
              (result) {
                debugPrint("SET LAST STORY");
                emit(const StoriesState.deleteStory());
              },
            );
          } else {
            final response = await _deleteLastStoryUsecase.call(NoParams());
            response.fold(
              (failure) =>
                  emit(StoriesState.deleteStoryError(failure.getMessage())),
              (result) {
                debugPrint("DELETE LAST STORY");
                emit(const StoriesState.deleteStory());
              },
            );
          }
        } else {
          debugPrint("============>");
          emit(const StoriesState.deleteStory());
        }
      },
    );
  }

  ContactStoryModel? contactStoryModel;
  List<ContactStoryModel> contactsStories = [];
  List<ContactStoryModel> recentStories = [];
  List<ContactStoryModel> viewedStories = [];
  List<String> contactsStoriesPhones = [];
  // bool empty = true;
  void openContactStory({required ContactStoryModel contactStoryModel}) {
    this.contactStoryModel = contactStoryModel;
    emit(const StoriesState.openContactStory());
  }

  Future<void> getContactsCurrentStories({bool loading = false}) async {
    if (loading) {
      emit(const StoriesState.getContactsCurrentStoriesLoading());
    }
    final response =
        await _getContactsCurrentStoriesUsecase.call(di<HomeCubit>().users);
    response.fold(
      (failure) => emit(StoriesState.testSuccess(
          myStories, contactsStories, failure.getMessage())),
      (stories) {
        viewedStories = [];
        recentStories = [];
        contactsStories = stories == null
            ? []
            : stories
                .where((e) => e.stories!
                    .where((element) => (DateTime.now()
                        .toUtc()
                        .isBefore(DateTime.parse(element.validateTo!))))
                    .toList()
                    .isNotEmpty)
                .toList();
        for (var contactStory in contactsStories) {
          if (contactStory.stories!.last.viewersPhones!
              .contains(_userStorage.getUser()!.phone)) {
            viewedStories
                .add(contactStory.copyWith(stories: contactStory.stories!));
          } else {
            recentStories
                .add(contactStory.copyWith(stories: contactStory.stories!));
          }
        }
        viewedStories.sort(
          (a, b) => DateTime.parse(a.stories!.last.date!)
              .compareTo(DateTime.parse(b.stories!.last.date!)),
        );

        recentStories.sort(
          (a, b) => DateTime.parse(a.stories!.last.date!)
              .compareTo(DateTime.parse(b.stories!.last.date!)),
        );

        recentStories = recentStories.reversed.toList();
        viewedStories = viewedStories.reversed.toList();
        emit(StoriesState.testSuccess(myStories, contactsStories, null));
      },
    );
  }

  Future<void> getContactsStories() async {
    final response = await _getContactsLastStoriesUsecase.call(NoParams());
    response.fold(
      (failure) => emit(StoriesState.testSuccess(
        myStories,
        contactsStories,
        failure.getMessage(),
      )),
      (stream) async {
        stream.listen((event) {
          debugPrint("============>STREAM");
          getContactsCurrentStories(loading: false);
        });
      },
    );
  }

  bool refreshButton = false;
  void showRefreshButton({required bool refreshButton}) {
    this.refreshButton = refreshButton;
    emit(const StoriesState.showRefreshButton());
  }

  TextEditingController? replyController;
  void initReplyToStory() {
    replyController = TextEditingController();
    emit(const StoriesState.initReplyToStory());
  }

  void viewContactStory({required StoryModel storyModel}) async {
    emit(const StoriesState.viewContactStoryLoading());
    storyModel.viewers!.add(ViewerModel(
      id: _userStorage.getUser()!.uId,
      phoneNumber: _userStorage.getUser()!.phone,
      dateTime: DateTime.now().toString(),
    ).toJson());

    storyModel.viewersPhones!.add(_userStorage.getUser()!.phone!);

    // debugPrint("=========>${storyModel.toJson()}");
    final response = await _updateStoryUsecase.call(UpdateStoryParams(
      storyModel: storyModel,
      phoneNumber: contactStoryModel!.user!.phone!,
    ));

    response.fold(
      (failure) => null,
      (result) {
        emit(const StoriesState.viewContactStory());
        getContactsStories();
        // emit(const StoriesState.viewContactStory());
      },
    );
  }

  void replyToStory() async {
    emit(const StoriesState.replyToStoryLoading());

    MessageModel messageModel = MessageModel(
      senderId: _userStorage.getUser()!.uId,
      receiverId: contactStoryModel!.user!.uId,
      message: replyController!.text,
      date: DateTime.now().toUtc().toString(),
      media: "",
      isImage: false,
      isVideo: false,
      isDoc: false,
      isStoryReply: true,
      storyText: contactStoryModel!.stories![storyIndex].text,
      storyMedia: contactStoryModel!.stories![storyIndex].media,
      storyDate: contactStoryModel!.stories![storyIndex].date,
      isStoryImageReply: contactStoryModel!.stories![storyIndex].isImage,
    );

    LastMessageModel lastMessageModel = LastMessageModel(
      token: contactStoryModel!.user!.token,
      image: contactStoryModel!.user!.image,
      senderID: messageModel.senderId,
      receiverID: messageModel.receiverId,
      message: messageModel.message,
      date: messageModel.date,
      media: messageModel.media,
      isImage: messageModel.isImage,
      isVideo: messageModel.isVideo,
      isDoc: messageModel.isDoc,
      isDeleted: messageModel.isDeleted,
      isRead: false,
    );

    final response = await _sendMessageUsecase.call(
      SendMessageParams(
        phoneNumber: contactStoryModel!.user!.phone!,
        lastMessageModel: lastMessageModel,
        messageModel: messageModel,
      ),
    );

    response.fold(
      (failure) => emit(StoriesState.replyToStoryError(failure.getMessage())),
      (result) async {
        await _pushNotificationUsecase.call(
            AppFunctions.getMessageNotificationFcmBody(
                user: contactStoryModel!.user!));
        di<StoriesCubit>().replyController!.clear();
        emit(const StoriesState.replyToStory());
      },
    );
  }

  Map<String, String> videosThumbnails = {};
  void createVideosThumbnails() async {
    final videoStories =
        myStories.where((element) => element.isVideo == true).toList();

    if (videoStories.isNotEmpty) {
      for (var story in videoStories) {
        if (!videosThumbnails.keys.contains(story.id!)) {
          String? videoThumbnail;
          try {
            videoThumbnail = await VideoThumbnail.thumbnailFile(
              video: story.media!,
              thumbnailPath: (await getTemporaryDirectory()).path,
              imageFormat: ImageFormat.WEBP,
              maxHeight: 64,
              quality: 75,
            );
          } catch (error) {
            videoThumbnail = "";
            debugPrint("===========>Error in get video thumbnail");
          }

          videosThumbnails[story.id!] = videoThumbnail!;
        }
      }
    }
    emit(const StoriesState.createVideosThumbnails());
  }
}
