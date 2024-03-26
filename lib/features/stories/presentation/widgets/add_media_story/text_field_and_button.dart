import 'package:flutter/material.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_media_story/caption_text_field.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_text_story/send_story_button.dart';

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
