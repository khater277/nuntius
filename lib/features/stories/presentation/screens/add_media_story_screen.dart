import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_media_story/image_story.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_media_story/text_field_and_button.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_media_story/video_story.dart';

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
          orElse: () {},
        );
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: state.maybeWhen(
              pickStoryMediaLoading: (type) =>
                  const Center(child: CustomCircleIndicator()),
              orElse: () => di<StoriesCubit>().storyFile == null
                  ? const Center(child: CustomCircleIndicator())
                  : Stack(
                      children: [
                        if (widget.messageType == MessageType.image)
                          const ImageStory(),
                        if (widget.messageType == MessageType.video)
                          const VideoStory(),
                        const CloseButton(),
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
