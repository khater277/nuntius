import 'package:flutter/material.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/font_styles.dart';
import 'package:intl/intl.dart' as intl;

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final int? maxlength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFelidSubmitted;
  final void Function()? onTap;
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.maxlength,
    this.obscureText = false,
    this.readOnly = false,
    required this.controller,
    this.onChange,
    this.onFelidSubmitted,
    this.onTap,
    required this.inputType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: intl.Bidi.detectRtlDirectionality(controller.text)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        // onTapOutside: (event) => FocusScope.of(context).unfocus(),
        maxLength: maxlength,
        style: getSemiBoldStyle(
            fontColor: Theme.of(context).textTheme.bodyLarge!.color!),
        validator: validator,
        onChanged: onChange,
        onFieldSubmitted: onFelidSubmitted,
        onTap: onTap,
        readOnly: readOnly,
        cursorColor: AppColors.blue,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.blue,
                  size: AppSize.s20,
                )
              : null,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
