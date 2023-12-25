import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: di<StoriesCubit>().replyController!,
                builder: (BuildContext context, value, Widget? child) {
                  return IconButton(
                    onPressed: value.text.isNotEmpty
                        ? () {
                            di<StoriesCubit>().replyToStory(
                              user: di<StoriesCubit>().contactStoryModel!.user!,
                              story: di<StoriesCubit>()
                                  .contactStoryModel!
                                  .stories![di<StoriesCubit>().storyIndex],
                            );
                            // di<StoriesCubit>().sendMessage(
                            //   friendToken: userToken,
                            //   friendID: userID,
                            //   message: finalMessage,
                            //   isStoryReply: true,
                            //   isStoryVideoReply:
                            //       mediaSource == MediaSource.video ? true : null,
                            //   storyMedia: storyMedia,
                            //   storyDate: storyDate,
                            // );

                            di<StoriesCubit>().replyController!.clear();
                          }
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
                        color:
                            value.text.isEmpty ? Colors.grey : AppColors.blue,
                      ),
                    ),
                  );
                },
              ),
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
