import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/local_storage/user_storage.dart';
import 'package:nuntius_/core/shared_widgets/snack_bar.dart';
import 'package:nuntius_/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius_/features/auth/presentation/widgets/auth_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/features/home/presentation/screens/home_screen.dart';

class SetImageNextButton extends StatelessWidget {
  const SetImageNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          addUserToFirestoreError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          uploadImageToStorageError: (errorMsg) =>
              errorSnackBar(context: context, errorMsg: errorMsg),
          addUserToFirestore: () =>
              Go.off(context: context, screen: const HomeScreen()),
          updateUserToken: () =>
              Go.off(context: context, screen: const HomeScreen()),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ValueListenableBuilder<TextEditingValue>(
            valueListenable: di<AuthCubit>().nameController!,
            builder: (BuildContext context, value, Widget? child) {
              return AuthFloatingButton(
                visibleCondition: (di<AuthCubit>().profileImage != null ||
                    (di<UserStorage>().getData() != null &&
                        value.text != di<UserStorage>().getData()!.name)),
                loadingCondition: state.maybeWhen(
                  addUserToFirestoreLoading: () => true,
                  uploadImageToStorageLoading: () => true,
                  orElse: () => false,
                ),
                onPressed: () {
                  if (di<AuthCubit>().profileImage != null) {
                    di<AuthCubit>().uploadImageToStorage();
                  } else {
                    di<AuthCubit>().addUserToFirestore();
                  }
                },
              );
            });
      },
    );
  }
}
