import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';

class AddContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddContactAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: LargeHeadText(
        text: "Add Contact",
        size: FontSize.s17,
        letterSpacing: 1,
      ),
      leading: IconButton(
        onPressed: () => Go.back(context: context),
        icon: Icon(
          IconBroken.Arrow___Left_2,
          size: AppSize.s18,
        ),
      ),
      actions: [
        BlocConsumer<ContactsCubit, ContactsState>(
          listener: (context, state) {
            state.maybeWhen(
              addContact: () => showSnackBar(
                context: context,
                message: "${di<ContactsCubit>().firstNameController!.text}"
                    "${di<ContactsCubit>().lastNameController!.text} added to your contacts",
                color: AppColors.blue,
              ),
              addContactError: (errorMsg) =>
                  errorSnackBar(context: context, errorMsg: errorMsg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidth.w5),
              child: IconButton(
                  onPressed: state.maybeWhen(
                      addContactLoading: () => null,
                      orElse: () => () {
                            if (di<ContactsCubit>()
                                .formKey!
                                .currentState!
                                .validate()) {
                              di<ContactsCubit>().addNewContact();
                            }
                          }),
                  icon: state.maybeWhen(
                    addContactLoading: () => CustomCircleIndicator(
                      size: AppSize.s20,
                    ),
                    orElse: () => const Icon(
                      IconBroken.Add_User,
                      color: AppColors.blue,
                    ),
                  )),
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
