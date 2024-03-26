import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/stories/presentation/widgets/story_view/my_story_viewers/viewer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewersBottomSheet extends StatelessWidget {
  final List<UserData> users;
  final List<String> viewsDateTime;
  const ViewersBottomSheet(
      {super.key, required this.users, required this.viewsDateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w4),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s10),
              topRight: Radius.circular(AppSize.s10),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: AppHeight.h13, bottom: AppHeight.h8),
              child: LargeHeadText(
                text: "Total viewers ${users.length}",
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: users.length < 10
                  ? 8.h + (users.length * 31.h)
                  : MediaQuery.sizeOf(context).height * 0.5,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppHeight.h5, horizontal: AppWidth.w4),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ViewerDetails(
                          user: users[index],
                          viewDateTime: viewsDateTime[index],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: AppHeight.h2);
                  },
                  itemCount: users.length),
            ),
          ],
        ),
      ),
    );
  }
}
