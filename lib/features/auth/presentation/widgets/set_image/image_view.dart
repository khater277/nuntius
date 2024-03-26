import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_images.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: AppSize.s60,
              backgroundImage: di<AuthCubit>().profileImage != null
                  ? FileImage(di<AuthCubit>().profileImage!)
                  : di<UserStorage>().getUser() != null &&
                          di<UserStorage>().getUser()!.image != ""
                      ? NetworkImage(di<UserStorage>().getUser()!.image!)
                          as ImageProvider
                      : const AssetImage(
                          AppImages.user,
                        ),
              backgroundColor: AppColors.lightBlack,
            ),
            CircleAvatar(
              radius: AppSize.s15,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: GestureDetector(
                onTap: () => di<AuthCubit>().pickProfileImage(),
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppHeight.h1),
                  child: Icon(
                    IconBroken.Camera,
                    color: AppColors.blue,
                    size: AppSize.s20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
