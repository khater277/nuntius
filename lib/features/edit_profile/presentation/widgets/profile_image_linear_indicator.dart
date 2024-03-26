import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';

class ProfileImageLinearIndicator extends StatelessWidget {
  const ProfileImageLinearIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) => state.maybeWhen(
        updateProfileImageLoading: () => LinearProgressIndicator(
          minHeight: 2,
          color: AppColors.blue.withOpacity(0.5),
          backgroundColor: AppColors.lightBlack,
        ),
        getProfileImagePercentage: (percentage) => LinearProgressIndicator(
          value: di<EditProfileCubit>().profileImagePercentage,
          minHeight: 2,
          color: AppColors.blue.withOpacity(0.7),
          backgroundColor: AppColors.lightBlack,
        ),
        orElse: () => const SizedBox(),
      ),
    );
  }
}
