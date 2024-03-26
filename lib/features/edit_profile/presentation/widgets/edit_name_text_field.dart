import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';

class EditNameTextField extends StatelessWidget {
  const EditNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [NoLeadingSpaceFormatter()],
      controller: di<EditProfileCubit>().nameController,
      maxLength: 25,
      style: getMediumStyle(
          fontColor: AppColors.white, fontSize: FontSize.s13, letterSpacing: 1),
      decoration: InputDecoration(
        counterStyle: TextStyle(
          color: AppColors.grey,
          fontSize: FontSize.s12,
        ),
        suffixStyle: TextStyle(color: AppColors.grey, fontSize: FontSize.s12),
        contentPadding: EdgeInsets.symmetric(
            vertical: AppHeight.h1, horizontal: AppWidth.w4),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue),
        ),
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimmedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection(
          baseOffset: trimmedText.length,
          extentOffset: trimmedText.length,
        ),
      );
    }
    return newValue;
  }
}
