import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nuntius_/core/apis/agora/agora_api.dart';
import 'package:nuntius_/core/apis/agora/agora_end_points.dart';
import 'package:nuntius_/core/apis/fcm/fcm_api.dart';
import 'package:nuntius_/core/apis/fcm/fcm_end_points.dart';
import 'package:nuntius_/core/firebase/auth/auth.dart';
import 'package:nuntius_/core/firebase/firestore/calls_database.dart';
import 'package:nuntius_/core/firebase/firestore/chats_database.dart';
import 'package:nuntius_/core/firebase/firestore/messages_database.dart';
import 'package:nuntius_/core/firebase/firestore/stories_database.dart';
import 'package:nuntius_/core/firebase/firestore/users_database.dart';
import 'package:nuntius_/core/firebase/storage/storage.dart';
import 'package:nuntius_/core/local_notification/display_local_notification.dart';
import 'package:nuntius_/core/local_notification/local_notification_actions.dart';
import 'package:nuntius_/core/local_notification/local_notification_initializer.dart';
import 'package:nuntius_/core/local_notification/local_notification_permissions.dart';
import 'package:nuntius_/core/local_notification/local_notification_platforms_initialization.dart';
import 'package:nuntius_/core/local_notification/streams/did_receive_local_notification_stream.dart';
import 'package:nuntius_/core/local_notification/streams/select_notification_stream.dart';
import 'package:nuntius_/core/local_storage/all_users_storage.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/network/network_info.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:nuntius_/features/auth/domain/repository/auth_repository.dart';
import 'package:nuntius_/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nuntius_/features/auth/domain/usecases/add_user_to_firestore_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/get_all_users_from_firestore_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/update_user_token_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/upload_file_to_storage_usecase.dart';
import 'package:nuntius_/features/auth/domain/usecases/verify_phone_number_usecase.dart';
import 'package:nuntius_/features/calls/cubit/calls_cubit.dart';
import 'package:nuntius_/features/calls/data/datasources/calls_remote_data_source.dart';
import 'package:nuntius_/features/calls/data/repositories/calls_repository.dart';
import 'package:nuntius_/features/calls/data/repositories/calls_repository_impl.dart';
import 'package:nuntius_/features/chats/data/datasources/chats_remote_data_source.dart';
import 'package:nuntius_/features/chats/domain/repositories/chats_repository.dart';
import 'package:nuntius_/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:nuntius_/features/chats/domain/usecases/get_chats_usecase.dart';
import 'package:nuntius_/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius_/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius_/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:nuntius_/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:nuntius_/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:nuntius_/features/edit_profile/domain/usecases/update_profile_data_usecase.dart';
import 'package:nuntius_/features/home/cubit/home_cubit.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/data/datasources/messages_remote_data_source.dart';
import 'package:nuntius_/features/messages/domain/repository/messages_repository.dart';
import 'package:nuntius_/features/messages/data/repositories/messages_repository_impl.dart';
import 'package:nuntius_/features/messages/domain/usecases/delete_last_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/delete_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/get_messages_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/get_user_stream_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/push_notification_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/see_message_usecase.dart';
import 'package:nuntius_/features/messages/domain/usecases/send_message_usecase.dart';
import 'package:nuntius_/features/search/cubit/search_cubit.dart';
import 'package:nuntius_/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:nuntius_/features/stories/data/repositories/stories_repository.dart';
import 'package:nuntius_/features/stories/data/repositories/stories_repository_impl.dart';

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
        addUserToFirestoreUsecase: di(),
        getAllUsersFromFirestoreUsecase: di(),
      ));
  di.registerLazySingleton<CallsCubit>(() => CallsCubit(
        callsRepository: di(),
        userStorage: di(),
      ));
  di.registerLazySingleton<ChatsCubit>(() => ChatsCubit(
        getChatsUsecase: di(),
        homeCubit: di(),
      ));
  di.registerLazySingleton<StoriesCubit>(() => StoriesCubit(
        authRepository: di(),
        storiesRepository: di(),
        messagesRepository: di(),
        userStorage: di(),
      ));
  di.registerLazySingleton<ContactsCubit>(() => ContactsCubit());
  di.registerLazySingleton<MessagesCubit>(() => MessagesCubit(
        userStorage: di(),
        callsRepository: di(),
        getUserStreamUsecase: di(),
        sendMessageUsecase: di(),
        getMessagesUsecase: di(),
        pushNotificationUsecase: di(),
        deleteMessageUsecase: di(),
        deleteLastMessageUsecase: di(),
        seeMessageUsecase: di(),
        uploadFileToStorageUsecase: di(),
      ));
  di.registerLazySingleton<SearchCubit>(() => SearchCubit(homeCubit: di()));

  di.registerLazySingleton<EditProfileCubit>(() => EditProfileCubit(
        updateProfileDataUsecase: di(),
        uploadFileToStorageUsecase: di(),
        userStorage: di(),
      ));

  /// DATASOURCES
  di.registerLazySingleton<CallsRemoteDataSource>(
      () => CallsRemoteDataSourceImpl(
            agoraApi: di(),
            fcmApi: di(),
            callsDatabase: di(),
          ));
  di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        authViaFirebase: di(),
        usersDatabase: di(),
        firebaseMedia: di(),
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
      () => EditProfileRemoteDataSourceImpl(usersDatabase: di()));

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

  /// EDIT PROFILE
  di.registerLazySingleton<UpdateProfileDataUsecase>(
      () => UpdateProfileDataUsecase(editProfileRepository: di()));

  ///LOCAL STORAGE
  di.registerLazySingleton<UserStorage>(() => UserStorage());
  di.registerLazySingleton<AllUsersStorage>(() => AllUsersStorage());

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
  di.registerLazySingleton<UsersDatabase>(
      () => UsersDatabaseImpl(userStorage: di()));
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
            "key=AAAAtA396zI:APA91bF7St3PW9Au3T7cuudgMsua-9UUKl9dlyYjngO9m5QcHVz_qLbULTicQ7eBvAOw9bwUYhnm8kj4jHf9yxVK-KEsTI19DF6cayVmCTHXH5cKybobLWy40-ZXdjLh9ZKAzOWx3xM1"
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
