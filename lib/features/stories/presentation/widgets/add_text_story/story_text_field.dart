import 'package:nuntius_/core/utils/font_styles.dart';
import 'package:flutter/material.dart';

class StoryTextField extends StatelessWidget {
  final TextEditingController controller;
  const StoryTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 20,
      autofocus: true,
      style: getSemiBoldStyle(
          fontColor: Theme.of(context).textTheme.bodyLarge!.color!),
      decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          hintText: 'Type story...',
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(0)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(0)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(0))),
    );
  }
}
