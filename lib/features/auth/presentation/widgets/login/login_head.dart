import 'package:flutter/material.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_strings.dart';
import 'package:nuntius/core/utils/app_values.dart';

class LoginHead extends StatelessWidget {
  const LoginHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LargeHeadText(
          text: AppStrings.askForPhoneNumber,
          size: FontSize.s18,
        ),
        SizedBox(height: AppHeight.h5),
        const SecondaryText(
          text: AppStrings.askForPhoneNumberHint,
          isButton: true,
          isEllipsis: false,
        ),
      ],
    );
  }
}
