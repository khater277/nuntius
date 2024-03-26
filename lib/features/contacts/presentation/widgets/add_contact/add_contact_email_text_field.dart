import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_text_field_and_title.dart';
import 'package:flutter/material.dart';

class AddContactEmailTextField extends StatelessWidget {
  const AddContactEmailTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AddContactTextFieldAndTitle(
      controller: di<ContactsCubit>().emailController!,
      title: 'Email',
      hint: 'email address..',
      inputType: TextInputType.emailAddress,
      icon: IconBroken.Message,
    );
  }
}
