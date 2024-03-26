import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/features/calls/data/models/live_call_data.dart';
import 'package:nuntius/features/calls/presentation/screens/live_call_screen.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius/features/messages/presentation/widgets/app_bar/messages_app_bar.dart';
import 'package:nuntius/features/messages/presentation/widgets/message_text_field/message_text_field.dart';
import 'package:nuntius/features/messages/presentation/widgets/messages_list.dart';

class MessagesScreen extends StatefulWidget {
  final String phoneNumber;
  // final String name;
  final bool fromNotification;
  const MessagesScreen({
    super.key,
    required this.phoneNumber,
    // required this.name,
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
    super.initState();
  }

  @override
  void dispose() {
    di<MessagesCubit>().disposeMessages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      listener: (context, state) {
        state.maybeWhen(
          downloadDocMessageError: (messageId, errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          openDocMessageError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          generateToken: (token, channelName, callType) => Go.to(
              context: context,
              screen: LiveCallScreen(
                liveCallData: LiveCallData(
                  callType: callType,
                  userToken: di<MessagesCubit>().user!.token!,
                  rtcToken: token,
                  channelName: channelName,
                  image: di<MessagesCubit>().user!.image!,
                  name: di<MessagesCubit>().user!.name!,
                  phoneNumber: di<MessagesCubit>().user!.phone!,
                  receiveCall: false,
                ),
              )),
          generateTokenError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () => false,
        );
      },
      buildWhen: (previous, current) => current.maybeWhen(
        getUserLoading: () => true,
        getMessages: (messages) => true,
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
            appBar: MessagesAppBar(
                name: di<MessagesCubit>().user == null
                    ? widget.phoneNumber
                    : di<MessagesCubit>().user!.name!),
            body: const Column(
              children: [
                MessagesList(),
                SendMessageTextField(),
              ],
            ),
          ),
        );
      },
    );
  }
}
