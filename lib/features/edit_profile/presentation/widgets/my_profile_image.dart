import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              pickProfileImageError: (errorMsg) =>
                  errorSnackBar(context: context, errorMsg: errorMsg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                if (di<EditProfileCubit>().profileImage != null)
                  CircleAvatar(
                    radius: AppSize.s60,
                    backgroundColor: AppColors.lightBlack,
                    backgroundImage:
                        FileImage(di<EditProfileCubit>().profileImage!),
                  )
                else if (di<UserStorage>().getUser() != null &&
                    di<UserStorage>().getUser()!.image!.isNotEmpty)
                  CircleAvatar(
                    radius: AppSize.s60,
                    backgroundColor: AppColors.lightBlack,
                    backgroundImage: CachedNetworkImageProvider(
                        di<UserStorage>().getUser()!.image!),
                  )
                else
                  CircleAvatar(
                    radius: AppSize.s60,
                    backgroundColor: AppColors.lightBlack,
                    child: Icon(
                      IconBroken.Profile,
                      color: AppColors.blue,
                      size: AppSize.s60,
                    ),
                  ),
                GestureDetector(
                  onTap: () => di<EditProfileCubit>().pickProfileImage(),
                  child: CircleAvatar(
                    radius: AppSize.s18,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Icon(
                      IconBroken.Camera,
                      color: AppColors.blue,
                      size: AppSize.s20,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
