import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/screens/set_image_screen.dart';
import 'package:nuntius/features/auth/presentation/widgets/otp/otp_fields.dart';
import 'package:nuntius/features/auth/presentation/widgets/otp/otp_head.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  final bool fromLogout;
  final bool deleteAccount;
  const OtpScreen(
      {super.key,
      required this.phoneNumber,
      required this.fromLogout,
      this.deleteAccount = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: deleteAccount
            ? AppBar(
                leading: const CustomBackButton(),
                titleSpacing: 0.0,
                title: LargeHeadText(
                  text: "Verification",
                  size: FontSize.s15,
                  letterSpacing: 1.2,
                ),
              )
            : null,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppHeight.h60,
              horizontal: AppWidth.w20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OtpHead(phoneNumber: phoneNumber),
                SizedBox(height: AppHeight.h50),
                BlocListener<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      deleteAccountError: (errorMsg) {
                        Go.back(context: context);
                        errorSnackBar(context: context, errorMsg: errorMsg);
                      },
                      orElse: () {},
                    );
                  },
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        submitOtp: () {
                          if (deleteAccount) {
                            showAlertDialog(
                              context: context,
                              text:
                                  "Are you sure you want to delete your account.",
                              okPressed: () =>
                                  di<EditProfileCubit>().deleteAccount(),
                            );
                          } else {
                            Go.offAll(
                              context: context,
                              screen: SetImageScreen(fromLogout: fromLogout),
                            );
                          }
                        },
                        errorState: (errorMsg) =>
                            errorSnackBar(context: context, errorMsg: errorMsg),
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        submitOtpLoading: () => Center(
                          child: CustomCircleIndicator(
                            color: AppColors.blue,
                            size: AppSize.s40,
                          ),
                        ),
                        orElse: () => const OtpFields(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
