import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendStoryButton extends StatelessWidget {
  final MessageType storyType;
  const SendStoryButton({super.key, required this.storyType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
      child: BlocConsumer<StoriesCubit, StoriesState>(
        buildWhen: (previous, current) => current.maybeWhen(
          getFilePercentage: (filePercentage) => false,
          orElse: () => true,
        ),
        listener: (context, state) {
          state.maybeWhen(
            sendStoryError: (errorMsg) =>
                errorSnackBar(context: context, errorMsg: errorMsg),
            sendStory: () => Go.back(context: context),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return IconButton(
              onPressed: state.maybeWhen(
                sendStoryLoading: () => null,
                orElse: () => () {
                  storyType == MessageType.text
                      ? di<StoriesCubit>().sendStory()
                      : di<StoriesCubit>().sendMediaStory(mediaType: storyType);
                },
              ),
              icon: state.maybeWhen(
                sendStoryLoading: () => CustomCircleIndicator(
                  color: AppColors.white,
                  size: AppSize.s18,
                  strokeWidth: 1.2,
                ),
                orElse: () => const Icon(
                  IconBroken.Send,
                  color: AppColors.white,
                ),
              ));
        },
      ),
    );
  }
}
