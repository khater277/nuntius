import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class ReplyToStoryButton extends StatelessWidget {
  const ReplyToStoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoriesCubit, StoriesState>(
      buildWhen: (previous, current) => current.maybeWhen(
        replyToStoryLoading: () => true,
        replyToStory: () => true,
        replyToStoryError: (errorMsg) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          // replyToStory: () => Go.back(context: context),
          replyToStoryError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: di<StoriesCubit>().replyController!,
          builder: (BuildContext context, value, Widget? child) {
            return IconButton(
              onPressed: value.text.isNotEmpty
                  ? () => di<StoriesCubit>().replyToStory()
                  : null,
              icon: state.maybeWhen(
                replyToStoryLoading: () => SizedBox(
                    width: AppSize.s15,
                    height: AppSize.s15,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSize.s2,
                    )),
                orElse: () => Icon(
                  IconBroken.Send,
                  size: AppSize.s20,
                  color: value.text.isEmpty ? Colors.grey : AppColors.blue,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
