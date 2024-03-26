import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nuntius/core/apis/agora/agora_api.dart';
import 'package:nuntius/core/apis/agora/agora_end_points.dart';
import 'package:nuntius/core/apis/fcm/fcm_api.dart';
import 'package:nuntius/core/apis/fcm/fcm_end_points.dart';
import 'package:nuntius/core/firebase/auth/auth.dart';
import 'package:nuntius/core/firebase/fcm/fcm_helper.dart';
import 'package:nuntius/core/firebase/firestore/calls_database.dart';
import 'package:nuntius/core/firebase/firestore/chats_database.dart';
import 'package:nuntius/core/firebase/firestore/messages_database.dart';
import 'package:nuntius/core/firebase/firestore/stories_database.dart';
import 'package:nuntius/core/firebase/firestore/users_database.dart';
import 'package:nuntius/core/firebase/storage/storage.dart';
import 'package:nuntius/core/local_notification/display_local_notification.dart';
import 'package:nuntius/core/local_notification/local_notification_actions.dart';
import 'package:nuntius/core/local_notification/local_notification_initializer.dart';
import 'package:nuntius/core/local_notification/local_notification_permissions.dart';
import 'package:nuntius/core/local_notification/local_notification_platforms_initialization.dart';
import 'package:nuntius/core/local_notification/streams/did_receive_local_notification_stream.dart';
import 'package:nuntius/core/local_notification/streams/select_notification_stream.dart';
import 'package:nuntius/core/local_storage/all_users_storage.dart';
import 'package:nuntius/core/local_storage/calls_storage.dart';
import 'package:nuntius/core/local_storage/chats_storage.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/network/network_info.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nuntius/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';
import 'package:nuntius/features/auth/domain/usecases/add_user_to_firestore_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/get_all_users_from_firestore_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/update_user_token_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius/features/auth/domain/usecases/verify_phone_number_usecase.dart';
import 'package:nuntius/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius/features/calls/data/datasources/calls_remote_data_source.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';
import 'package:nuntius/features/calls/data/repositories/calls_repository_impl.dart';
import 'package:nuntius/features/calls/domain/usecases/add_new_call_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/generate_token_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/get_calls_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/update_call_usecase.dart';
import 'package:nuntius/features/calls/domain/usecases/update_in_call_usecase.dart';
import 'package:nuntius/features/chats/data/datasources/chats_remote_data_source.dart';
import 'package:nuntius/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:nuntius/features/chats/domain/repositories/chats_repository.dart';
import 'package:nuntius/features/chats/domain/usecases/delete_chat_usecase.dart';
import 'package:nuntius/features/chats/domain/usecases/get_chats_usecase.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:nuntius/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:nuntius/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:nuntius/features/edit_profile/domain/usecases/delete_account_usecase.dart';
import 'package:nuntius/features/edit_profile/domain/usecases/update_profile_data_usecase.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/data/datasources/messages_remote_data_source.dart';
import 'package:nuntius/features/messages/data/repositories/messages_repository_impl.dart';
import 'package:nuntius/features/messages/domain/repository/messages_repository.dart';
import 'package:nuntius/features/messages/domain/usecases/delete_last_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/delete_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/get_messages_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/get_user_stream_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/see_message_usecase.dart';
import 'package:nuntius/features/messages/domain/usecases/send_message_usecase.dart';
import 'package:nuntius/features/search/cubit/search_cubit.dart';
import 'package:nuntius/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:nuntius/features/stories/data/repositories/stories_repository_impl.dart';
import 'package:nuntius/features/stories/domain/repositories/stories_repository.dart';
import 'package:nuntius/features/stories/domain/usecases/delete_last_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/delete_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_contacts_current_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_contacts_last_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/get_stories_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/send_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/set_last_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/update_last_story_usecase.dart';
import 'package:nuntius/features/stories/domain/usecases/update_story_usecase.dart';

import '../features/chats/cubit/chats_cubit.dart';
import '../features/stories/cubit/stories_cubit.dart';

final di = GetIt.instance;

void setupGetIt() {
  /// CUBITS
  di.registerLazySingleton<AuthCubit>(() => AuthCubit(
        userStorage: di(),
        allUsersStorage: di(),
        verifyPhoneNumberUsecase: di(),
        signInWithPhoneNumberUsecase: di(),
        addUserToFirestoreUsecase: di(),
        getAllUsersFromFirestoreUsecase: di(),
        updateUserTokenUsecase: di(),
        uploadFileToStorageUsecase: di(),
      ));
  di.registerLazySingleton<HomeCubit>(() => HomeCubit(
        userStorage: di(),
        allUsersStorage: di(),
        chatsStorage: di(),
        callsStorage: di(),
        addUserToFirestoreUsecase: di(),
        getAllUsersFromFirestoreUsecase: di(),
        getUserStreamUsecase: di(),
      ));
  di.registerLazySingleton<CallsCubit>(() => CallsCubit(
        homeCubit: di(),
        userStorage: di(),
        callsStorage: di(),
        getCallsUsecase: di(),
        addNewCallUsecase: di(),
        updateCallUsecase: di(),
        updateInCallUsecase: di(),
        pushNotificationUsecase: di(),
      ));
  di.registerLazySingleton<ChatsCubit>(() => ChatsCubit(
        getChatsUsecase: di(),
        deleteChatUsecase: di(),
        homeCubit: di(),
        chatsStorage: di(),
      ));
  di.registerLazySingleton<StoriesCubit>(() => StoriesCubit(
        sendStoryUsecase: di(),
        deleteStoryUsecase: di(),
        updateStoryUsecase: di(),
        getStoriesUsecase: di(),
        setLastStoryUsecase: di(),
        deleteLastStoryUsecase: di(),
        getContactsCurrentStoriesUsecase: di(),
        getContactsLastStoriesUsecase: di(),
        sendMessageUsecase: di(),
        uploadFileToStorageUsecase: di(),
        pushNotificationUsecase: di(),
        userStorage: di(),
      ));
  di.registerLazySingleton<ContactsCubit>(() => ContactsCubit(
        homeCubit: di(),
        chatsCubit: di(),
      ));
  di.registerLazySingleton<MessagesCubit>(() => MessagesCubit(
        userStorage: di(),
        chatsStorage: di(),
        generateTokenUsecase: di(),
        getUserStreamUsecase: di(),
        sendMessageUsecase: di(),
        getMessagesUsecase: di(),
        pushNotificationUsecase: di(),
        deleteMessageUsecase: di(),
        deleteLastMessageUsecase: di(),
        seeMessageUsecase: di(),
        uploadFileToStorageUsecase: di(),
      ));
  di.registerLazySingleton<SearchCubit>(() => SearchCubit(
        homeCubit: di(),
        chatsCubit: di(),
      ));

  di.registerLazySingleton<EditProfileCubit>(() => EditProfileCubit(
        updateProfileDataUsecase: di(),
        uploadFileToStorageUsecase: di(),
        deleteAccountUsecase: di(),
        userStorage: di(),
        chatsStorage: di(),
        callsStorage: di(),
      ));

  /// DATASOURCES
  di.registerLazySingleton<CallsRemoteDataSource>(
      () => CallsRemoteDataSourceImpl(
            agoraApi: di(),
            fcmApi: di(),
            callsDatabase: di(),
            usersDatabase: di(),
            userStorage: di(),
          ));
  di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        authViaFirebase: di(),
        usersDatabase: di(),
        firebaseMedia: di(),
        userStorage: di(),
      ));
  di.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSourceImpl(
            messagesDatabase: di(),
            fcmApi: di(),
          ));
  di.registerLazySingleton<ChatsRemoteDataSource>(
      () => ChatsRemoteDataSourceImpl(
            chatsDatabase: di(),
          ));
  di.registerLazySingleton<StoriesRemoteDataSource>(
      () => StoriesRemoteDataSourceImpl(
            storiesDatabase: di(),
          ));

  di.registerLazySingleton<EditProfileRemoteDataSource>(
      () => EditProfileRemoteDataSourceImpl(
            usersDatabase: di(),
            userStorage: di(),
          ));

  /// REPOSITORIES
  di.registerLazySingleton<CallsRepository>(() => CallsRepositoryImpl(
        callsRemoteDataSource: di(),
        networkInfo: di(),
      ));
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: di(),
        networkInfo: di(),
        userStorage: di(),
        allUsersStorage: di(),
      ));
  di.registerLazySingleton<MessagesRepository>(() => MessagesRepositoryImpl(
        messagesRemoteDataSource: di(),
        networkInfo: di(),
      ));
  di.registerLazySingleton<ChatsRepository>(() => ChatsRepositoryImpl(
        chatsRemoteDataSource: di(),
        networkInfo: di(),
      ));

  di.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
        storiesRemoteDataSource: di(),
        networkInfo: di(),
      ));

  di.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(
            editProfileRemoteDataSource: di(),
            networkInfo: di(),
          ));

  /// USECASES
  /// AUTH
  di.registerLazySingleton<VerifyPhoneNumberUsecase>(
      () => VerifyPhoneNumberUsecase(authRepository: di()));
  di.registerLazySingleton<SignInWithPhoneNumberUsecase>(
      () => SignInWithPhoneNumberUsecase(authRepository: di()));
  di.registerLazySingleton<AddUserToFirestoreUsecase>(
      () => AddUserToFirestoreUsecase(authRepository: di()));
  di.registerLazySingleton<GetAllUsersFromFirestoreUsecase>(
      () => GetAllUsersFromFirestoreUsecase(authRepository: di()));
  di.registerLazySingleton<UpdateUserTokenUsecase>(
      () => UpdateUserTokenUsecase(authRepository: di()));
  di.registerLazySingleton<UploadFileToStorageUsecase>(
      () => UploadFileToStorageUsecase(authRepository: di()));

  /// MESSAGES
  di.registerLazySingleton<SendMessageUsecase>(
      () => SendMessageUsecase(messagesRepository: di()));
  di.registerLazySingleton<DeleteMessageUsecase>(
      () => DeleteMessageUsecase(messagesRepository: di()));
  di.registerLazySingleton<DeleteLastMessageUsecase>(
      () => DeleteLastMessageUsecase(messagesRepository: di()));
  di.registerLazySingleton<SeeMessageUsecase>(
      () => SeeMessageUsecase(messagesRepository: di()));
  di.registerLazySingleton<GetMessagesUsecase>(
      () => GetMessagesUsecase(messagesRepository: di()));
  di.registerLazySingleton<GetUserStreamUsecase>(
      () => GetUserStreamUsecase(messagesRepository: di()));
  di.registerLazySingleton<PushNotificationUsecase>(
      () => PushNotificationUsecase(messagesRepository: di()));

  /// CHATS
  di.registerLazySingleton<GetChatsUsecase>(
      () => GetChatsUsecase(chatsRepository: di()));
  di.registerLazySingleton<DeleteChatUsecase>(
      () => DeleteChatUsecase(chatsRepository: di()));

  /// EDIT PROFILE
  di.registerLazySingleton<UpdateProfileDataUsecase>(
      () => UpdateProfileDataUsecase(editProfileRepository: di()));
  di.registerLazySingleton<DeleteAccountUsecase>(
      () => DeleteAccountUsecase(editProfileRepository: di()));

  /// STORIES
  di.registerLazySingleton<SendStoryUsecase>(
      () => SendStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<UpdateStoryUsecase>(
      () => UpdateStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<DeleteStoryUsecase>(
      () => DeleteStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<GetStoriesUsecase>(
      () => GetStoriesUsecase(storiesRepository: di()));
  di.registerLazySingleton<SetLastStoryUsecase>(
      () => SetLastStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<UpdateLastStoryUsecase>(
      () => UpdateLastStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<DeleteLastStoryUsecase>(
      () => DeleteLastStoryUsecase(storiesRepository: di()));
  di.registerLazySingleton<GetContactsCurrentStoriesUsecase>(
      () => GetContactsCurrentStoriesUsecase(storiesRepository: di()));
  di.registerLazySingleton<GetContactsLastStoriesUsecase>(
      () => GetContactsLastStoriesUsecase(storiesRepository: di()));

  /// CALLS
  di.registerLazySingleton<GetCallsUsecase>(
      () => GetCallsUsecase(callsRepository: di()));
  di.registerLazySingleton<GenerateTokenUsecase>(
      () => GenerateTokenUsecase(callsRepository: di()));
  di.registerLazySingleton<AddNewCallUsecase>(
      () => AddNewCallUsecase(callsRepository: di()));
  di.registerLazySingleton<UpdateCallUsecase>(
      () => UpdateCallUsecase(callsRepository: di()));
  di.registerLazySingleton<UpdateInCallUsecase>(
      () => UpdateInCallUsecase(callsRepository: di()));

  ///LOCAL STORAGE
  di.registerLazySingleton<UserStorage>(() => UserStorageImpl());
  di.registerLazySingleton<AllUsersStorage>(() => AllUsersStorageImpl());
  di.registerLazySingleton<ChatsStorage>(() => ChatsStorageImpl());
  di.registerLazySingleton<CallsStorage>(() => CallsStorageImpl());

  ///LOCAL NOTIFICATION SERVICE
  di.registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin());
  di.registerLazySingleton<LocalNotificationActions>(
      () => LocalNotificationActionsImpl(
            selectNotificationStream: di(),
          ));
  di.registerLazySingleton<DisplayLocalNotification>(() =>
      DisplayLocalNotificationImpl(flutterLocalNotificationsPlugin: di()));
  di.registerLazySingleton<LocalNotificationInitializer>(
      () => LocalNotificationInitializerImpl(
            flutterLocalNotificationsPlugin: di(),
            selectNotificationStream: di(),
            localNotificationPlatformInitialization: di(),
          ));
  di.registerLazySingleton<LocalNotificationPermissions>(() =>
      LocalNotificationPermissionsImpl(flutterLocalNotificationsPlugin: di()));
  di.registerLazySingleton<LocalNotificationPlatformInitialization>(() =>
      LocalNotificationPlatformInitializationImpl(
          didReceiveLocalNotificationStream: di()));
  di.registerLazySingleton<DidReceiveLocalNotificationStream>(
      () => DidReceiveLocalNotificationStream());
  di.registerLazySingleton<SelectNotificationStream>(
      () => SelectNotificationStream());

  /// NETWORK INFO
  di.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: di()));
  di.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  /// FIREBASE
  di.registerLazySingleton<AuthViaFirebase>(() => AuthViaFirebaseImpl());
  di.registerLazySingleton<FirebaseMedia>(() => FirebaseMediaImpl());
  di.registerLazySingleton<FcmHelper>(() => FcmHelperImpl(
        messagesCubit: di(),
        displayLocalNotification: di(),
      ));
  di.registerLazySingleton<UsersDatabase>(() => UsersDatabaseImpl(
        chatsDatabase: di(),
        messagesDatabase: di(),
        storiesDatabase: di(),
        callsDatabase: di(),
        userStorage: di(),
      ));
  di.registerLazySingleton<ChatsDatabase>(
      () => ChatsDatabaseImpl(userStorage: di()));
  di.registerLazySingleton<MessagesDatabase>(
      () => MessagesDatabaseImpl(userStorage: di()));
  di.registerLazySingleton<StoriesDatabase>(
      () => StoriesDatabaseImpl(userStorage: di()));
  di.registerLazySingleton<CallsDatabase>(
      () => CallsDatabaseImpl(userStorage: di()));

  /// APIS
  di.registerLazySingleton<AgoraApi>(
      () => AgoraApi(di(instanceName: 'agora-dio')));
  di.registerLazySingleton<FcmApi>(() => FcmApi(di(instanceName: 'fcm-dio')));

  /// DIOs
  Dio createAndSetupAgoraDio() {
    Dio dio = Dio();

    dio.options
      ..baseUrl = AgoraEndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..headers = {
        'Content-Type': 'application/json',
      }
      ..connectTimeout = const Duration(seconds: 20)
      ..followRedirects = false;

    dio.interceptors.add(
      LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          error: true),
    );

    return dio;
  }

  di.registerLazySingleton<Dio>(
    () => createAndSetupAgoraDio(),
    instanceName: 'agora-dio',
  );

  Dio createAndSetupFcmDio() {
    Dio dio = Dio();

    dio.options
      ..baseUrl = FcmEndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..headers = {
        'Content-Type': 'application/json',
        'Authorization':
            "key=AAAAdm4qWw8:APA91bEDXxk1nAzpSzUkmHMUffGZcXbFXzN8k-OqOFnkhlvSJczc4s1wSO532SSBAEwA2xX0tu94tTJi0ySD76KiKZaRyONX57MPc5UcsI7lROWQYxm_bh8ucg2I2UvpOasBgmeIXfff"
      }
      ..connectTimeout = const Duration(seconds: 20)
      ..followRedirects = false;

    dio.interceptors.add(
      LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          error: true),
    );

    return dio;
  }

  di.registerLazySingleton<Dio>(
    () => createAndSetupFcmDio(),
    instanceName: 'fcm-dio',
  );
}
