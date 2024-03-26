import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:flutter/material.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: const CustomBackButton(),
      title: LargeHeadText(
        text: "Profile",
        color: AppColors.blue,
        size: FontSize.s17,
        letterSpacing: 1.5,
      ),
      actions: [
        BlocConsumer<EditProfileCubit, EditProfileState>(
          buildWhen: (previous, current) => current.maybeWhen(
            updateProfileImageLoading: () => true,
            updateProfileImageError: (errorMsg) => true,
            updateProfileImage: () => true,
            pickProfileImage: () => true,
            orElse: () => false,
          ),
          listener: (context, state) {
            state.maybeWhen(
              updateProfileImageError: (errorMsg) =>
                  errorSnackBar(context: context, errorMsg: errorMsg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            if (di<EditProfileCubit>().profileImage == null) {
              return const SizedBox();
            } else {
              return TextButton(
                onPressed: () => state.maybeWhen(
                  updateProfileImageLoading: () => () {},
                  orElse: () => di<EditProfileCubit>().uploadProfileImage(),
                ),
                child: const Text(
                  "UPLOAD",
                  style: TextStyle(color: AppColors.white),
                ),
              );
            }
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
