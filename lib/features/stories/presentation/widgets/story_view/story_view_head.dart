import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/user_image.dart';
import 'package:nuntius/features/stories/presentation/widgets/stories/contact_story/story_date.dart';

import '../../../../auth/data/models/user_data/user_data.dart';

class StoryViewHead extends StatelessWidget {
  const StoryViewHead({
    super.key,
    required this.storyDate,
    required this.user,
  });

  final String storyDate;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppHeight.h10, horizontal: AppWidth.w5),
      child: Row(
        children: [
          UserImage(
            image: user.image!,
            isChat: true,
          ),
          SizedBox(width: AppWidth.w4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LargeHeadText(
                text: user == di<UserStorage>().getUser()
                    ? "My story"
                    : user.name!,
                size: FontSize.s14,
              ),
              SizedBox(height: AppHeight.h2),
              StoryDate(storyDate: storyDate)
            ],
          ),
        ],
      ),
    );
  }
}
