import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';
import 'package:nuntius/features/auth/presentation/widgets/set_image/image_view.dart';
import 'package:nuntius/features/auth/presentation/widgets/set_image/name_text_field.dart';
import 'package:nuntius/features/auth/presentation/widgets/set_image/set_image_head.dart';
import 'package:nuntius/features/auth/presentation/widgets/set_image/set_image_next_button.dart';
import 'package:nuntius/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetImageScreen extends StatefulWidget {
  final bool fromLogout;
  const SetImageScreen({super.key, required this.fromLogout});

  @override
  State<SetImageScreen> createState() => _SetImageScreenState();
}

class _SetImageScreenState extends State<SetImageScreen> {
  @override
  void initState() {
    di<AuthCubit>().initNameController();
    super.initState();
  }

  @override
  void dispose() {
    di<AuthCubit>().disposeNameController();
    super.dispose();
  }

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
              context: context,
              screen: HomeScreen(fromLogout: widget.fromLogout)),
          updateUserToken: () => Go.off(
              context: context,
              screen: HomeScreen(fromLogout: widget.fromLogout)),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () => di<AuthCubit>().addUserToFirestore(),
                child: state.maybeWhen(
                  addUserToFirestoreLoading: () =>
                      CustomCircleIndicator(size: AppSize.s18, strokeWidth: 1),
                  orElse: () => const LargeHeadText(
                    text: "SKIP",
                    color: AppColors.blue,
                  ),
                ),
              )
            ],
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SetImageHead(),
                        SizedBox(height: AppHeight.h15),
                        const ImageView(),
                        SizedBox(height: AppHeight.h30),
                        const NameTextField(),
                      ],
                    ),
                    SizedBox(
                      height: AppHeight.h30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: const SetImageNextButton(),
        );
      },
    );
  }
}
