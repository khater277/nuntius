import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius/features/edit_profile/presentation/widgets/edit_my_name.dart';

class MyName extends StatelessWidget {
  const MyName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.h4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            IconBroken.Profile,
            size: AppSize.s20,
            color: AppColors.grey,
          ),
          SizedBox(width: AppWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeadText(
                    text: "Name", size: FontSize.s13, color: AppColors.white),
                SizedBox(height: AppHeight.h1),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    return LargeHeadText(
                        text: di<UserStorage>().getUser() != null
                            ? di<UserStorage>().getUser()!.name!
                            : "",
                        size: FontSize.s13,
                        color: Colors.blue);
                  },
                ),
                SizedBox(height: AppHeight.h2),
                LargeHeadText(
                  text:
                      "This is not your username or pin. This name will be visible to your NUNTIUS contacts",
                  size: FontSize.s10,
                  color: Colors.grey,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const EditMyName(),
        ],
      ),
    );
  }
}
