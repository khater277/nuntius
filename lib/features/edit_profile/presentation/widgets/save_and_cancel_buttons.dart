import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/edit_profile/cubit/edit_profile_cubit.dart';

class SaveAndCancelButtons extends StatelessWidget {
  const SaveAndCancelButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () => Go.back(context: context),
          child: const Text("CANCEL"),
        ),
        BlocConsumer<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            state.maybeWhen(
              updateProfileName: () => Go.back(context: context),
              updateProfileNameError: (errorMsg) =>
                  errorSnackBar(context: context, errorMsg: errorMsg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              updateProfileNameLoading: () => CustomCircleIndicator(
                strokeWidth: 1,
                size: AppSize.s18,
              ),
              orElse: () => TextButton(
                onPressed: () => di<EditProfileCubit>().updateProfileName(),
                child: const Text("SAVE"),
              ),
            );
          },
        ),
      ],
    );
  }
}
