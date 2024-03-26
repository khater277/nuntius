import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';

class CloseMediaContainerButton extends StatelessWidget {
  const CloseMediaContainerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeight.h4, right: AppWidth.w4),
      child: InkWell(
        onTap: () => di<MessagesCubit>().closeMediaContainer(),
        child: const Icon(
          IconBroken.Close_Square,
          color: AppColors.red,
        ),
      ),
    );
  }
}
