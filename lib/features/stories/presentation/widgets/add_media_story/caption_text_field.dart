import 'package:nuntius_/core/shared_widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class CaptionTextField extends StatelessWidget {
  final TextEditingController controller;
  const CaptionTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        controller: controller,
        inputType: TextInputType.text,
        hintText: "add a caption...",
      ),
    );
  }
}
