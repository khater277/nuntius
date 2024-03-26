import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';

class MyPhoneNumber extends StatelessWidget {
  const MyPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppHeight.h4, horizontal: AppWidth.w4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconBroken.Call,
            size: AppSize.s20,
            color: AppColors.grey,
          ),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeadText(
                    text: "Phone number",
                    size: FontSize.s13,
                    color: Colors.white),
                SizedBox(height: AppHeight.h1),
                LargeHeadText(
                    text: di<UserStorage>().getUser()!.phone!,
                    size: FontSize.s12,
                    color: AppColors.blue),
              ],
            ),
          ),
          // Icon(IconBroken.Edit,size: 16.sp,color: AppColors.grey,),
        ],
      ),
    );
  }
}
