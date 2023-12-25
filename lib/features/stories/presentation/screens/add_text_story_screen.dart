import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/back_button.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_text_story/send_story_button.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_text_story/story_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTextStoryScreen extends StatefulWidget {
  const AddTextStoryScreen({super.key});

  @override
  State<AddTextStoryScreen> createState() => _AddTextStoryScreenState();
}

class _AddTextStoryScreenState extends State<AddTextStoryScreen> {
  @override
  void initState() {
    di<StoriesCubit>().initAddTextStory();
    super.initState();
  }

  @override
  void dispose() {
    di<StoriesCubit>().disposeAddTextStory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesCubit, StoriesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        sendStoryLoading: () => true,
        sendStoryError: (errorMsg) => true,
        sendStory: () => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          sendStoryError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          sendStory: () => Go.back(context: context),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(leading: const CustomBackButton()),
            body: state.maybeWhen(
              sendStoryLoading: () =>
                  const Center(child: CustomCircleIndicator()),
              orElse: () => Padding(
                padding: EdgeInsets.only(top: AppHeight.h6),
                child: StoryTextField(),
              ),
            ),
            floatingActionButton: const SendStoryButton(
              storyType: MessageType.text,
            ),
          ),
        );
      },
    );
  }
}
