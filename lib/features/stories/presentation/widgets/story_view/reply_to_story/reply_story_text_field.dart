import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/reply_to_story/reply_to_story_button.dart';

class ReplyStoryTextField extends StatelessWidget {
  const ReplyStoryTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesCubit, StoriesState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            autofocus: true,
            cursorColor: AppColors.grey.withOpacity(0.7),
            controller: di<StoriesCubit>().replyController,
            keyboardType: TextInputType.text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: FontSize.s14,
                ),
            decoration: InputDecoration(
              hintText: "type your reply...",
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: FontSize.s12,
                  color: AppColors.grey.withOpacity(0.6)),
              suffixIcon: const ReplyToStoryButton(),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppHeight.h5, horizontal: AppWidth.w10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: const BorderSide(color: AppColors.blue)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s30),
                  borderSide: const BorderSide(color: AppColors.blue)),
            ),
          ),
        );
      },
    );
  }
}
