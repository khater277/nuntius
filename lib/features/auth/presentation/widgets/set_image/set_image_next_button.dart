import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/local_storage/user_storage.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/widgets/auth_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/features/home/presentation/screens/home_screen.dart';

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
          addUserToFirestore: () => Go.off(
              context: context, screen: const HomeScreen(fromLogout: false)),
          updateUserToken: () => Go.off(
              context: context, screen: const HomeScreen(fromLogout: false)),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return ValueListenableBuilder<TextEditingValue>(
            valueListenable: di<AuthCubit>().nameController!,
            builder: (BuildContext context, value, Widget? child) {
              return AuthFloatingButton(
                visibleCondition: state.maybeWhen(
                  uploadImageToStorageLoading: () =>
                      (di<AuthCubit>().profileImage != null ||
                          (di<UserStorage>().getUser() != null &&
                              value.text != di<UserStorage>().getUser()!.name)),
                  orElse: () => false,
                ),
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
