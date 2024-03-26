import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';

class ScrollDownButton extends StatelessWidget {
  final bool receiveMessage;
  const ScrollDownButton({
    super.key,
    required this.receiveMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidth.w6, vertical: AppHeight.h5),
        child: SizedBox(
          width: AppSize.s30,
          height: AppSize.s30,
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              FloatingActionButton(
                onPressed: () => di<MessagesCubit>().scrollDown(),
                shape: const CircleBorder(),
                backgroundColor: AppColors.lightBlack,
                child: Icon(
                  IconBroken.Arrow___Down_2,
                  size: AppSize.s15,
                  color: AppColors.blue,
                ),
              ),
              if (receiveMessage)
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppHeight.h2, horizontal: AppWidth.w3),
                  child: Container(
                    width: AppSize.s6,
                    height: AppSize.s6,
                    decoration: const BoxDecoration(
                        color: AppColors.blue, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
