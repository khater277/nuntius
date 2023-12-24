import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/presentation/widgets/app_bar/messages_app_bar.dart';
import 'package:nuntius_/features/messages/presentation/widgets/message_text_field/message_text_field.dart';
import 'package:nuntius_/features/messages/presentation/widgets/messages_list.dart';

class MessagesScreen extends StatefulWidget {
  // final UserData user;
  final String phoneNumber;
  final bool fromNotification;
  const MessagesScreen({
    super.key,
    required this.phoneNumber,
    // required this.user,
    this.fromNotification = false,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  ValueNotifier<bool> showScrollDownButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    di<MessagesCubit>().initMessages(phoneNumber: widget.phoneNumber);
    // MessagesCubit.get(context)
    //     .readMessage(lastMessages: ChatsCubit.get(context).lastMessages);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.fromNotification == false) {
      di<MessagesCubit>().disposeMessages();
    }
    super.dispose();
  }

  // void goToCallScreen(BuildContext context, String rtcToken, String channelName,
  //     CallType callType) {
  //   if (callType == CallType.voice) {
  //     Go.to(
  //       context: context,
  //       screen: VoiceCallScreen(
  //         userToken: MessagesCubit.get(context).user!.token!,
  //         rtcToken: rtcToken,
  //         channelName: channelName,
  //         image: MessagesCubit.get(context).user!.image!,
  //         name: MessagesCubit.get(context).user!.name!,
  //         phoneNumber: MessagesCubit.get(context).user!.phone!,
  //       ),
  //     );
  //   } else {
  //     Go.to(
  //       context: context,
  //       screen: VideoCallScreen(
  //         userToken: MessagesCubit.get(context).user!.token!,
  //         rtcToken: rtcToken,
  //         channelName: channelName,
  //         image: MessagesCubit.get(context).user!.image!,
  //         name: MessagesCubit.get(context).user!.name!,
  //         phoneNumber: MessagesCubit.get(context).user!.phone!,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        getUserLoading: () => true,
        getUser: (user) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          getUserLoading: () => const Scaffold(
            body: Center(
              child: CustomCircleIndicator(),
            ),
          ),
          orElse: () => Scaffold(
            appBar: const MessagesAppBar(),
            body: BlocBuilder<MessagesCubit, MessagesState>(
              buildWhen: (previous, current) => current.maybeWhen(
                getMessagesLoading: () => true,
                getMessages: (messages) => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                return Center(
                  child: state.maybeWhen(
                    getMessagesLoading: () => const CustomCircleIndicator(),
                    orElse: () => const Column(
                      children: [
                        MessagesList(),
                        SendMessageTextField(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    // BlocConsumer<MessagesCubit, MessagesState>(
    //   listener: (context, state) {
    //     state.maybeWhen(
    //       deleteMessage: () {
    //         Go.back(context: context);
    //         Go.back(context: context);
    //       },
    //       // generateToken: (rtcToken, channelName, callType) {
    //       //   goToCallScreen(context, rtcToken, channelName, callType);
    //       // },
    //       generateTokenError: (errorMsg) => errorSnackBar(
    //           context: context,
    //           errorMsg: "$errorMsg , please check agora token server."),
    //       sendMessageError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       deleteMessageError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       openDocMessageError: (errorMsg) =>
    //           errorSnackBar(context: context, errorMsg: errorMsg),
    //       orElse: () {},
    //     );
    //   },
    //   builder: (context, state) {
    //     return state.maybeWhen(
    //         getMessagesLoading: () => const Scaffold(
    //               body: Center(child: CustomCircleIndicator()),
    //             ),
    //         orElse: () => PopScope(
    //               onPopInvoked: (didPop) => di<MessagesCubit>().readMessage(
    //                   lastMessages: ChatsCubit.get(context).lastMessages),
    //               child: GestureDetector(
    //                 onTap: () => FocusScope.of(context).unfocus(),
    //                 child: Scaffold(
    //                   appBar: const MessagesAppBar(),
    //                   body: Padding(
    //                     padding: EdgeInsets.only(
    //                       top: AppHeight.h5,
    //                       right: AppWidth.w5,
    //                       left: AppWidth.w5,
    //                     ),
    //                     child: ValueListenableBuilder(
    //                       valueListenable: showScrollDownButton,
    //                       builder: (BuildContext context, bool value,
    //                           Widget? child) {
    //                         return NotificationListener(
    //                           onNotification: (notification) {
    //                             if (notification is ScrollEndNotification) {
    //                               if (di<MessagesCubit>()
    //                                       .scrollController!
    //                                       .position
    //                                       .minScrollExtent !=
    //                                   di<MessagesCubit>()
    //                                       .scrollController!
    //                                       .position
    //                                       .pixels) {
    //                                 showScrollDownButton.value = true;
    //                                 print(
    //                                     "=================>${showScrollDownButton.value}");
    //                               } else {
    //                                 showScrollDownButton.value = false;
    //                               }
    //                             }
    //                             return true;
    //                           },
    //                           child: Column(
    //                             children: [
    //                               Expanded(
    //                                 child: Stack(
    //                                   children: [
    //                                     MessagesList(),
    //                                     if (showScrollDownButton.value)
    //                                       ScrollDownButton(
    //                                           receiveMessage: state ==
    //                                               const MessagesState
    //                                                   .receiveMessage())
    //                                   ],
    //                                 ),
    //                               ),
    //                               SendMessageTextField(
    //                                 loadingCondition: state ==
    //                                         const MessagesState
    //                                             .sendMessageLoading() ||
    //                                     state ==
    //                                         const MessagesState
    //                                             .getFilePercentage(),
    //                               ),
    //                             ],
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ));
    //   },
    // );
  }
}
