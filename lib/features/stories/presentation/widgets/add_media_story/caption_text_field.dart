import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';

class CaptionTextField extends StatelessWidget {
  const CaptionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        controller: di<StoriesCubit>().storyTextController!,
        inputType: TextInputType.text,
        hintText: "add a caption...",
      ),
    );
  }
}
