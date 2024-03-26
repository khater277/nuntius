import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/shared_widgets/text_form_field.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class AddContactTextFieldAndTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType inputType;
  final IconData icon;
  final String? Function(String?)? validator;
  const AddContactTextFieldAndTitle({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    required this.inputType,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
          child: SecondaryText(
            text: title,
            size: FontSize.s13,
            isLight: true,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: AppHeight.h4),
        CustomTextField(
          hintText: hint,
          validator: validator,
          controller: controller,
          inputType: inputType,
          prefixIcon: icon,
        ),
      ],
    );
  }
}
