import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_media_story/Image_story.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_media_story/caption_text_field.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_media_story/video_story.dart';
import 'package:nuntius_/features/stories/presentation/widgets/add_text_story/send_story_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMediaStoryScreen extends StatefulWidget {
  final MessageType messageType;
  const AddMediaStoryScreen({
    super.key,
    required this.messageType,
  });

  @override
  State<AddMediaStoryScreen> createState() => _AddMediaStoryScreenState();
}

class _AddMediaStoryScreenState extends State<AddMediaStoryScreen> {
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
      listener: (context, state) {
        state.maybeWhen(
          pickStoryMediaError: () => Go.back(context: context),
          sendStoryError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          sendStory: () => Go.back(context: context),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: state.maybeWhen(
              pickStoryMediaLoading: (type) =>
                  const Center(child: CustomCircleIndicator()),
              orElse: () => Stack(
                children: [
                  if (widget.messageType == MessageType.image)
                    const ImageStory(),
                  if (widget.messageType == MessageType.video)
                    const VideoStory(),
                  const CloseButton(),
                  // Align(
                  //     alignment: AlignmentDirectional.center,
                  //     child: CustomCircleIndicator()),
                  AddMediaStoryTextFieldAndButton(
                      storyType: widget.messageType),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddMediaStoryTextFieldAndButton extends StatelessWidget {
  const AddMediaStoryTextFieldAndButton({
    super.key,
    required this.storyType,
  });

  final MessageType storyType;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppHeight.h6, horizontal: AppWidth.w6),
        child: Row(
          children: [
            const CaptionTextField(),
            SizedBox(width: AppWidth.w5),
            SendStoryButton(
              storyType: storyType,
            )
          ],
        ),
      ),
    );
  }
}
