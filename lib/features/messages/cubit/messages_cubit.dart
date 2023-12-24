import 'dart:io';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/firebase/collections_keys.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_functions.dart';
import 'package:nuntius_/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius_/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius_/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius_/features/calls/data/repositories/calls_repository.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:nuntius_/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius_/features/messages/data/models/message/message_model.dart';
import 'package:nuntius_/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius_/features/messages/domain/parameters/send_message_params.dart';
import 'package:nuntius_/features/messages/domain/usecases/delete_last_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/delete_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/get_messages_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/get_user_stream_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/see_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/send_message_usecase.dart';
import 'package:nuntius_/features/messages/presentation/widgets/delete_message/delete_message_bottom_sheet.dart';
import 'package:nuntius_/features/messages/presentation/widgets/message_bubble/doc_message.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'messages_cubit.freezed.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final UserStorage _userStorage;
  final CallsRepository _callsRepository;
  final GetUserStreamUsecase _getUserStreamUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final GetMessagesUsecase _getMessagesUsecase;
  final PushNotificationUsecase _pushNotificationUsecase;
  final DeleteMessageUsecase _deleteMessageUsecase;
  final DeleteLastMessageUsecase _deleteLastMessageUsecase;
  final SeeMessageUsecase _seeMessageUsecase;
  final UploadFileToStorageUsecase _uploadFileToStorageUsecase;
  MessagesCubit({
    required UserStorage userStorage,
    required CallsRepository callsRepository,
    required GetUserStreamUsecase getUserStreamUsecase,
    required SendMessageUsecase sendMessageUsecase,
    required GetMessagesUsecase getMessagesUsecase,
    required PushNotificationUsecase pushNotificationUsecase,
    required DeleteMessageUsecase deleteMessageUsecase,
    required DeleteLastMessageUsecase deleteLastMessageUsecase,
    required SeeMessageUsecase seeMessageUsecase,
    required UploadFileToStorageUsecase uploadFileToStorageUsecase,
  })  : _userStorage = userStorage,
        _callsRepository = callsRepository,
        _getUserStreamUsecase = getUserStreamUsecase,
        _sendMessageUsecase = sendMessageUsecase,
        _getMessagesUsecase = getMessagesUsecase,
        _pushNotificationUsecase = pushNotificationUsecase,
        _deleteMessageUsecase = deleteMessageUsecase,
        _deleteLastMessageUsecase = deleteLastMessageUsecase,
        _seeMessageUsecase = seeMessageUsecase,
        _uploadFileToStorageUsecase = uploadFileToStorageUsecase,
        super(const MessagesState.initial());

  TextEditingController? messageController;
  ScrollController? scrollController;

  void initMessages({required String phoneNumber}) async {
    messageController = TextEditingController();
    scrollController = ScrollController();
    // this.user = user;
    // homeCubit.initUser(user: user);
    // await getMessages(isInit: true, phoneNumber: phoneNumber);
    await getUser(phoneNumber: phoneNumber);
    await getMessages(phoneNumber: phoneNumber);
  }

  void disposeMessages() {
    scrollController!.dispose();
    videosThumbnails = {};
    messageType = null;
    file = null;
    emit(const MessagesState.disposeControllers());
  }

  UserData? user;
  Future<void> getUser({required String phoneNumber}) async {
    emit(const MessagesState.getUserLoading());
    final response = await _getUserStreamUsecase.call(phoneNumber);
    response.fold(
      (failure) {
        user = di<UserStorage>().getData()!;
        emit(MessagesState.getUser(user!));
      },
      (stream) {
        stream.listen((event) {
          final existedUser = di<HomeCubit>()
              .users
              .firstWhereOrNull((element) => element.phone == phoneNumber);
          if (existedUser != null) {
            user = existedUser.copyWith(
              token: UserData.fromJson(event.data()!).token,
              inCall: UserData.fromJson(event.data()!).inCall,
            );
          } else {
            user = UserData.fromJson(event.data()!)
                .copyWith(name: UserData.fromJson(event.data()!).phone);
          }
          emit(MessagesState.getUser(user!));
        });
      },
    );
  }

  List<MessageModel> messages = [];
  Future<void> getMessages({required String phoneNumber}) async {
    emit(const MessagesState.getMessagesLoading());
    final response = await _getMessagesUsecase.call(phoneNumber);
    response.fold(
      (failure) {
        emit(MessagesState.getMessagesError(failure.getMessage()));
      },
      (snapshots) {
        snapshots.listen((event) {
          List<MessageModel> messages = [];
          for (var doc in event.docs) {
            messages.add(MessageModel.fromJson(doc.data()));
          }
          this.messages = messages;
          final replyToStoryVideoMessages = messages
              .where((element) =>
                  (element.isStoryReply == true &&
                      element.storyMedia!.isNotEmpty &&
                      element.isStoryImageReply != true) &&
                  (!videosThumbnails.containsKey(element.messageId)))
              .toList();
          createVideosThumbnails(
              replyToStoryVideoMessages: replyToStoryVideoMessages);
          emit(MessagesState.getMessages(messages));
          // if (messages.isNotEmpty &&
          //     messages.last.senderId != _userStorage.getData()!.uId) {
          //   emit(const MessagesState.receiveMessage());
          // } else {
          //   emit(MessagesState.getMessages(messages));
          // }
        });
      },
    );
  }

  Map<String, String> videosThumbnails = {};
  void createVideosThumbnails(
      {required List<MessageModel> replyToStoryVideoMessages}) async {
    for (var message in replyToStoryVideoMessages) {
      String? videoThumbnail;
      try {
        videoThumbnail = await VideoThumbnail.thumbnailFile(
          video: message.storyMedia!,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.WEBP,
          maxHeight: 64,
          quality: 75,
        );
      } catch (error) {
        videoThumbnail = "";
        print("===========>Error in get video thumbnail");
      }
      videosThumbnails[message.messageId!] = videoThumbnail!;
    }
    // emit(const MessagesState.createVideosThumbnails());
  }

  Future<void> sendMessage({
    String? media,
    MessageType? messageType,
  }) async {
    if (media == null) emit(const MessagesState.sendMessageLoading());

    MessageModel messageModel = MessageModel(
      senderId: await SharedPrefHelper.getUid(),
      receiverId: user!.uId,
      message: messageType == MessageType.doc
          ? Uri.file(file!.path).pathSegments.last
          : messageController!.text,
      date: DateTime.now().toUtc().toString(),
      media: media,
      isImage: messageType == MessageType.image ? true : false,
      isVideo: messageType == MessageType.video ? true : false,
      isDoc: messageType == MessageType.doc ? true : false,
    );

    LastMessageModel lastMessageModel = LastMessageModel(
      token: user!.token,
      image: user!.image,
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
        phoneNumber: user!.phone!,
        lastMessageModel: lastMessageModel,
        messageModel: messageModel,
      ),
    );

    response.fold(
      (failure) => emit(MessagesState.sendMessageError(failure.getMessage())),
      (result) async {
        messageController!.clear();
        scrollDown();
        messageType = null;
        file = null;
        emit(const MessagesState.sendMessage());

        if (user!.token != _userStorage.getData()!.token) {
          final pushNotification = await _pushNotificationUsecase(
              AppFunctions.getMessageNotificationFcmBody(user: user!));
          pushNotification.fold((l) => print("NOT SENT"), (r) => print("SENT"));
        }
      },
    );
  }

  void scrollDown() {
    Future.delayed(const Duration(milliseconds: 600)).then((value) {
      if (scrollController!.positions.isNotEmpty) {
        scrollController!.animateTo(
          scrollController!.position.minScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
      emit(const MessagesState.scrollDown());
    });
  }

  ImagePicker picker = ImagePicker();
  MessageType? messageType;
  File? file;
  double? filePercentage;

  void closeMediaContainer() {
    messageType = null;
    file = null;
    emit(const MessagesState.closeMediaContainer());
  }

  Future<void> pickMessageImage() async {
    emit(const MessagesState.pickMessageImageLoading());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      messageType = MessageType.image;
      emit(const MessagesState.pickMessageImage());
    } else {
      debugPrint("NOT SELECTED");
      emit(const MessagesState.pickMessageImageError("NOT SELECTED"));
    }
  }

  Future<void> pickMessageVideo() async {
    emit(const MessagesState.pickMessageVideoLoading());
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);
      messageType = MessageType.video;
      emit(const MessagesState.pickMessageVideo());
    } else {
      debugPrint("NOT SELECTED");
      emit(const MessagesState.pickMessageVideoError("NOT SELECTED"));
    }
  }

  Future<void> pickMessageFile() async {
    emit(const MessagesState.pickMessageFileLoading());
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      file = File(pickedFile.path);
      messageType = MessageType.doc;
      emit(const MessagesState.pickMessageFile());
    } else {
      debugPrint("NOT SELECTED");
      emit(const MessagesState.pickMessageFileError("NOT SELECTED"));
    }
  }

  void sendMediaMessage() async {
    emit(const MessagesState.sendMessageLoading());
    final response = await _uploadFileToStorageUsecase(
        UploadFileToStorageParams(
            collectionName: Collections.messageImages, file: file!));
    response.fold(
      (failure) {
        emit(MessagesState.sendMessageError(failure.getMessage()));
      },
      (result) {
        result!.fold(
          (url) {
            sendMessage(
              media: url,
              messageType: messageType!,
            );
          },
          (taskSnapshot) {
            taskSnapshot.listen((event) async {
              switch (event.state) {
                case TaskState.running:
                  emit(const MessagesState.sendMessageLoading());
                  filePercentage = event.bytesTransferred / event.totalBytes;
                  debugPrint("===============> $filePercentage");
                  emit(const MessagesState.getFilePercentage());
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  sendMessage(
                    media: await event.ref.getDownloadURL(),
                    messageType: messageType!,
                  );
                  break;
                case TaskState.canceled:
                  emit(const MessagesState.sendMessageError(
                      "The operation has been cancelled."));
                  break;
                case TaskState.error:
                  emit(const MessagesState.sendMessageError(
                      "The operation has been failed."));
                  break;
              }
            });
          },
        );
      },
    );
  }

  void openDocMessage({required String url, required String id}) async {
    emit(MessagesState.openDocMessageLoading(id));
    DefaultCacheManager defaultCacheManager = DefaultCacheManager();
    try {
      final file =
          await CachedFileControllerService(defaultCacheManager).getFile(url);
      final filePath = file.absolute.path;
      try {
        await OpenFile.open(filePath);
        emit(const MessagesState.openDocMessage());
      } catch (error) {
        emit(const MessagesState.openDocMessageError("can't open file"));
      }
    } catch (error) {
      emit(const MessagesState.openDocMessageError("can't get file"));
    }
  }

  void showDeleteMessageBottomSheet({
    required BuildContext context,
    required String messageId,
    required bool loadingCondition,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DeleteMessageBottomSheet(messageId: messageId);
      },
    );
  }

  void deleteMessage({required String messageId}) async {
    emit(MessagesState.deleteMessageLoading(messageId));
    final response = await _deleteMessageUsecase.call(DeleteMessageParams(
      messageId: messageId,
      userPhone: user!.phone!,
    ));
    response.fold(
      (failure) => emit(MessagesState.deleteMessageError(failure.getMessage())),
      (result) async {
        if (messageId == messages.last.messageId) {
          final response = await _deleteLastMessageUsecase.call(user!.phone!);
          response.fold(
            (failure) =>
                emit(MessagesState.deleteMessageError(failure.getMessage())),
            (result) {
              emit(const MessagesState.deleteMessage());
            },
          );
        } else {
          emit(const MessagesState.deleteMessage());
        }
      },
    );
  }

  void generateToken({required CallType callType}) async {
    emit(MessagesState.generateTokenLoading(callType));
    String channelName = const Uuid().v4();
    final response = await _callsRepository.generateToken(
      channel: channelName,
      uid: "0",
    );
    response.fold(
      (failure) => emit(MessagesState.generateTokenError(failure.getMessage())),
      (agoraTokenModel) => emit(MessagesState.generateToken(
        agoraTokenModel.rtcToken!,
        channelName,
        callType,
      )),
    );
  }

  void seeMessage({required String phoneNumber}) async {
    final response = await _seeMessageUsecase.call(phoneNumber);
    response.fold(
      (failure) => null,
      (result) => print("====================>See Message Done"),
    );
  }

  void readMessage({required List<LastMessageModel> lastMessages}) {
    final lastMessage = lastMessages.firstWhereOrNull(
        (lastMessageModel) => lastMessageModel.senderID == user!.uId);
    if (lastMessage != null && lastMessage.isRead != true) {
      seeMessage(phoneNumber: user!.phone!);
    }
  }
}
