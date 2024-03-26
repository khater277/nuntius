import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class StoryTextField extends StatelessWidget {
  const StoryTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeight.h6),
      child: TextFormField(
        controller: di<StoriesCubit>().storyTextController!,
        keyboardType: TextInputType.text,
        maxLines: 20,
        autofocus: true,
        style: getSemiBoldStyle(
            fontColor: Theme.of(context).textTheme.bodyLarge!.color!),
        decoration: InputDecoration(
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintText: 'Type story...',
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(0))),
      ),
    );
  }
}
