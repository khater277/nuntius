import 'package:flutter/material.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_strings.dart';
import 'package:nuntius/core/utils/app_values.dart';

class OtpHead extends StatelessWidget {
  const OtpHead({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LargeHeadText(
          text: AppStrings.verifyNumber,
          size: FontSize.s18,
        ),
        SizedBox(height: AppHeight.h5),
        RichText(
          text: TextSpan(
            text: AppStrings.enterOtpCode,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: FontSize.s14,
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .color!
                      .withOpacity(0.8),
                  fontWeight: FontWeightManager.semiBold,
                  height: 1.5,
                ),
            children: [
              TextSpan(
                text: "+2$phoneNumber",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: FontSize.s15, color: AppColors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
