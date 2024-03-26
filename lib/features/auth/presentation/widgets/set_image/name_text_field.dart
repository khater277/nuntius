import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/text_form_field.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:nuntius/features/auth/cubit/auth_cubit.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w20),
      child: CustomTextField(
        hintText: "enter your name..",
        controller: di<AuthCubit>().nameController!,
        inputType: TextInputType.name,
      ),
    );
  }
}
