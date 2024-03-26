import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/firebase/collections_keys.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_preferences/shared_pref_helper.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_functions.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';
import 'package:nuntius/features/calls/domain/parameters/generate_token_params.dart';
import 'package:nuntius/features/calls/domain/usecases/generate_token_usecase.dart';
import 'package:nuntius/features/chats/data/models/chats_model.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/messages/data/models/last_message/last_message_model.dart';
import 'package:nuntius/features/messages/data/models/message/message_model.dart';
import 'package:nuntius/features/messages/domain/parameters/delete_message_params.dart';
import 'package:nuntius/features/messages/domain/parameters/send_message_params.dart';
import 'package:nuntius/features/messages/domain/usecases/delete_last_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/delete_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/get_messages_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/get_user_stream_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/see_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/send_message_usecase.dart';
import 'package:nuntius/features/messages/presentation/widgets/delete_message/delete_message_bottom_sheet.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'messages_cubit.freezed.dart';
part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final UserStorage _userStorage;
  final ChatsStorage _chatsStorage;
  final GenerateTokenUsecase _generateTokenUsecase;
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
    required ChatsStorage chatsStorage,
    required GenerateTokenUsecase generateTokenUsecase,
    required GetUserStreamUsecase getUserStreamUsecase,
    required SendMessageUsecase sendMessageUsecase,
    required GetMessagesUsecase getMessagesUsecase,
    required PushNotificationUsecase pushNotificationUsecase,
    required DeleteMessageUsecase deleteMessageUsecase,
    required DeleteLastMessageUsecase deleteLastMessageUsecase,
    required SeeMessageUsecase seeMessageUsecase,
    required UploadFileToStorageUsecase uploadFileToStorageUsecase,
  })  : _userStorage = userStorage,
        _chatsStorage = chatsStorage,
        _generateTokenUsecase = generateTokenUsecase,
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
    readMessage();
    user = null;
    videosThumbnails = {};
    file = null;
    emit(const MessagesState.disposeControllers());
  }

  UserData? user;
  Future<void> getUser({required String phoneNumber}) async {
    emit(const MessagesState.getUserLoading());
    final response = await _getUserStreamUsecase.call(phoneNumber);
    response.fold(
      (failure) {
        user = _userStorage.getUser()!;
        emit(MessagesState.getUser(user!));
      },
      (stream) {
        stream.listen((event) {
          if (event.data() != null) {
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
          } else {
            user = chat!.user;
          }

          emit(MessagesState.getUser(user!));
        });
      },
    );
  }

  ChatsModel? chat;
  Future<void> getMessages({required String phoneNumber}) async {
    emit(const MessagesState.getMessagesLoading());
    final response = await _getMessagesUsecase.call(phoneNumber);
    response.fold(
      (failure) {
        chat = _chatsStorage.getChat(phone: phoneNumber);
        emit(MessagesState.getMessagesError(failure.getMessage()));
      },
      (snapshots) async {
        if (await snapshots.isEmpty == false) {
          bool first = true;
          snapshots.listen((event) async {
            List<MessageModel> messages = [];
            for (var doc in event.docs) {
              messages.add(MessageModel.fromJson(doc.data()));
            }
            final docMessages =
                messages.where((element) => element.isDoc == true).toList();
            await handleDocMessages(docMessages: docMessages);

            final replyToStoryVideoMessages = messages
                .where((element) =>
                    (element.isStoryReply == true &&
                        element.storyMedia!.isNotEmpty &&
                        element.isStoryImageReply != true) &&
                    (!videosThumbnails.containsKey(element.messageId)))
                .toList();
            createVideosThumbnails(
                replyToStoryVideoMessages: replyToStoryVideoMessages);
            if (_chatsStorage.getChat(phone: phoneNumber) != null) {
              final chat = _chatsStorage
                  .getChat(phone: phoneNumber)!
                  .copyWith(messages: messages);
              this.chat = chat;
              _chatsStorage.saveChat(chatsModel: chat);
            } else {
              chat = ChatsModel(
                user: user!,
                messages: messages,
              );
            }

            if (first) {
              debugPrint("=======>READ MESSAGE");
              readMessage();
              first = false;
            }
            emit(MessagesState.getMessages(messages));
          });
        }
      },
    );
  }

  Map<String, bool> docMessagesStatus = {};
  Future<void> handleDocMessages(
      {required List<MessageModel> docMessages}) async {
    final directory = await getApplicationDocumentsDirectory();
    for (MessageModel docMessage in docMessages) {
      final filePath = "${directory.path}/${docMessage.message}";
      docMessagesStatus[docMessage.messageId!] = File(filePath).existsSync();
    }
    debugPrint("============>DOCS MESSAGES HANDLED");
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
        debugPrint("===========>Error in get video thumbnail");
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
        file = null;
        // if (messageType == MessageType.doc) {
        //   docMessagesStatus[messageModel.messageId!] = true;
        // }
        emit(const MessagesState.sendMessage());
        debugPrint(
            "============>${user!.token != _userStorage.getUser()!.token}");
        if (user!.token != _userStorage.getUser()!.token) {
          final pushNotification = await _pushNotificationUsecase(
              AppFunctions.getMessageNotificationFcmBody(user: user!));
          pushNotification.fold(
              (l) => debugPrint("NOT SENT"), (r) => debugPrint("SENT"));
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
  File? file;

  void closeMediaContainer() {
    file = null;
    emit(const MessagesState.closeMediaContainer());
  }

  Future<void> pickMediaMessage({required MessageType messageType}) async {
    emit(const MessagesState.pickMediaMessageLoading());
    File? pickedFile;
    if (messageType == MessageType.image) {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) pickedFile = File(image.path);
    } else if (messageType == MessageType.video) {
      final video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) pickedFile = File(video.path);
    } else if (messageType == MessageType.doc) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) pickedFile = File(result.files.single.path!);
    }
    if (pickedFile != null) {
      file = pickedFile;
      emit(MessagesState.pickMediaMessage(messageType));
    } else {
      emit(const MessagesState.pickMediaMessageError("NOT SELECTED"));
    }
  }

  void sendMediaMessage({required MessageType messageType}) async {
    emit(const MessagesState.sendMessageLoading());
    final directory = await getApplicationDocumentsDirectory();
    final fileName = Uri.file(file!.path).pathSegments.last;
    final filePath = "${directory.path}/$fileName";
    final response = await _uploadFileToStorageUsecase(
        UploadFileToStorageParams(
            collectionName: Collections.messageImages, file: file!));
    response.fold(
      (failure) {
        emit(MessagesState.sendMessageError(failure.getMessage()));
      },
      (result) {
        result!.fold(
          (url) async {
            if (!File(filePath).existsSync() &&
                messageType == MessageType.doc) {
              file!.copySync(filePath);
            }
            sendMessage(
              media: url,
              messageType: messageType,
            );
          },
          (taskSnapshot) {
            taskSnapshot.listen((event) async {
              switch (event.state) {
                case TaskState.running:
                  final percentage = event.bytesTransferred / event.totalBytes;
                  emit(
                      MessagesState.sendMessageLoading(percentage: percentage));
                  break;
                case TaskState.paused:
                  break;
                case TaskState.success:
                  if (!File(filePath).existsSync() &&
                      messageType == MessageType.doc) {
                    file!.copySync(filePath);
                  }
                  sendMessage(
                    media: await event.ref.getDownloadURL(),
                    messageType: messageType,
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

  void downloadDocMessage({
    required String url,
    required String messageId,
    required String docName,
  }) async {
    emit(MessagesState.downloadDocMessageLoading(messageId: messageId));
    final directory = await getApplicationDocumentsDirectory();
    final docPath = "${directory.path}/$docName";
    try {
      await Dio().download(
        url,
        docPath,
        onReceiveProgress: (count, total) {
          final percentage = count / total;
          emit(MessagesState.downloadDocMessageLoading(
            messageId: messageId,
            percentage: percentage,
          ));
        },
      );
      docMessagesStatus[messageId] = true;
      emit(MessagesState.downloadDocMessage(messageId));
    } catch (error) {
      emit(MessagesState.downloadDocMessageError(
          messageId, "Failed to download $docName"));
    }
  }

  Future _askRequiredPermission() async {
    await [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.accessMediaLocation
    ].request();
  }

  void openDocMessage({
    required String messageId,
    required String docName,
  }) async {
    emit(const MessagesState.openDocMessageLoading());
    final directory = await getApplicationDocumentsDirectory();
    final docPath = "${directory.path}/$docName";
    await _askRequiredPermission();
    final openResult = await OpenFile.open(docPath);
    switch (openResult.type) {
      case ResultType.done:
        emit(const MessagesState.openDocMessage());
      case ResultType.fileNotFound:
        emit(MessagesState.openDocMessageError("$docName not found"));
      case ResultType.noAppToOpen:
        emit(MessagesState.openDocMessageError("No app to open $docName"));
      case ResultType.permissionDenied:
        emit(const MessagesState.openDocMessageError(
            "Permission denied, please enable permission first."));
      case ResultType.error:
        emit(MessagesState.openDocMessageError("Unable to open $docName"));
    }
    // }
  }

  void showDeleteMessageBottomSheet({
    required BuildContext context,
    required String messageId,
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
        if (messageId == chat!.messages!.last.messageId) {
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
    final response = await _generateTokenUsecase.call(GenerateTokenParams(
      channel: channelName,
      uid: "0",
    ));
    response.fold(
      (failure) => emit(MessagesState.generateTokenError(failure.getMessage())),
      (agoraTokenModel) {
        emit(MessagesState.generateToken(
          agoraTokenModel.rtcToken!,
          channelName,
          callType,
        ));
      },
    );
  }

  void seeMessage({required String phoneNumber}) async {
    final response = await _seeMessageUsecase.call(phoneNumber);
    response.fold(
      (failure) => null,
      (result) => debugPrint("====================>See Message Done"),
    );
  }

  void readMessage() {
    final lastMessage = chat!.lastMessage;
    if (lastMessage != null && lastMessage.isRead != true) {
      seeMessage(phoneNumber: user!.phone!);
    }
  }
}
