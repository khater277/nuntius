import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/alert_dialog.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/screens/otp_screen.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          codeSent: () => Go.to(
            context: context,
            screen: OtpScreen(
              phoneNumber: di<UserStorage>().getUser()!.phone!.substring(2),
              fromLogout: true,
              deleteAccount: true,
            ),
          ),
          errorState: (errorMsg) {
            Go.back(context: context);
            errorSnackBar(context: context, errorMsg: errorMsg);
          },
          orElse: () {},
        );
      },
      child: GestureDetector(
        onTap: () => showAlertDialog(
          context: context,
          text: "Send otp code to ${di<UserStorage>().getUser()!.phone} ?",
          okPressed: () => di<AuthCubit>().signInWithPhoneNumber(
              phoneNumber: di<UserStorage>().getUser()!.phone!.substring(2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              IconBroken.Delete,
              size: AppSize.s20,
              color: AppColors.grey,
            ),
            SizedBox(width: AppWidth.w10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LargeHeadText(
                      text: "Delete Account",
                      size: FontSize.s13,
                      color: AppColors.white),
                  // SizedBox(height: AppHeight.h3),
                  LargeHeadText(
                    text:
                        "Your all data will be deleted chats, messages, stories and calls.",
                    size: FontSize.s10,
                    color: Colors.grey,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
