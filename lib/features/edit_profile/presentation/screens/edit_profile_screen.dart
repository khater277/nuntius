import 'package:flutter/material.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/features/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:nuntius_/features/edit_profile/presentation/widgets/app_bar.dart';
import 'package:nuntius_/features/edit_profile/presentation/widgets/my_name.dart';
import 'package:nuntius_/features/edit_profile/presentation/widgets/my_phone_number.dart';
import 'package:nuntius_/features/edit_profile/presentation/widgets/my_profile_image.dart';
import 'package:nuntius_/features/edit_profile/presentation/widgets/profile_image_linear_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    di<EditProfileCubit>().initEditProfileScreen();
    super.initState();
  }

  @override
  void dispose() {
    di<EditProfileCubit>().disposeEditProfileScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditProfileAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppHeight.h8, horizontal: AppWidth.w10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyProfileImage(),
              SizedBox(height: AppHeight.h6),
              const ProfileImageLinearIndicator(),
              SizedBox(height: AppHeight.h8),
              const MyName(),
              SizedBox(height: AppHeight.h8),
              const MyPhoneNumber()
            ],
          ),
        ),
      ),
    );
  }
}
