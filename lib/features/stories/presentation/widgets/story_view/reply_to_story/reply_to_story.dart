import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/reply_to_story/reply_story_text_field.dart';

class ReplyToStory extends StatefulWidget {
  const ReplyToStory({
    super.key,
  });

  @override
  State<ReplyToStory> createState() => _ReplyToStoryState();
}

class _ReplyToStoryState extends State<ReplyToStory> {
  @override
  void initState() {
    di<StoriesCubit>().initReplyToStory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        di<StoriesCubit>().storyController!.pause();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppHeight.h3, horizontal: AppWidth.w5),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.lightBlack,
                    borderRadius: BorderRadius.circular(AppSize.s5)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: AppHeight.h5,
                      bottom: AppHeight.h3,
                      left: AppWidth.w6,
                      right: AppWidth.w6),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ReplyStoryTextField()],
                  ),
                ),
              ),
            );
          },
        ).whenComplete(() {
          di<StoriesCubit>().replyController!.clear();
          di<StoriesCubit>().storyController!.play();
        });
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: AppHeight.h10),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                IconBroken.Arrow___Up_2,
                color: AppColors.grey,
                size: AppSize.s16,
              ),
              LargeHeadText(
                text: "Reply",
                size: AppSize.s12,
                color: AppColors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
