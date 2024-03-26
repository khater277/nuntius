import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';

class NoContactsFounded extends StatelessWidget {
  const NoContactsFounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconBroken.User1,
            size: AppSize.s100,
            color: AppColors.grey.withOpacity(0.4),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "add new ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: FontSize.s13,
                          color: AppColors.grey.withOpacity(0.5),
                          height: 1.5),
                      children: [
                        TextSpan(
                          text: "NUNTIUS ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: FontSize.s15,
                                  color: AppColors.blue.withOpacity(0.7)),
                        ),
                        TextSpan(
                            text:
                                "users to your contacts and start new conversations with them",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: FontSize.s13,
                                  color: AppColors.grey.withOpacity(0.5),
                                  height: 1.5,
                                )),
                      ]))),
        ],
      ),
    );
  }
}
