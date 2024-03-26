import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';

class ViewFile extends StatelessWidget {
  const ViewFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          IconBroken.Document,
          color: AppColors.blue,
          size: AppSize.s40,
        ),
        SizedBox(height: AppHeight.h10),
        SecondaryText(
          text: Uri.file(di<MessagesCubit>().file!.path).pathSegments.last,
          color: AppColors.white,
        ),
      ],
    );
  }
}
