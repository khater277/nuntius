import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_text_field_and_title.dart';
import 'package:flutter/material.dart';

class AddContactPhoneTextField extends StatelessWidget {
  const AddContactPhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return AddContactTextFieldAndTitle(
      controller: di<ContactsCubit>().phoneController!,
      title: 'Phone number',
      hint: 'phone number..',
      inputType: TextInputType.phone,
      icon: IconBroken.Call,
      validator: (value) {
        if (di<ContactsCubit>().phoneController!.text.isEmpty) {
          return """can't be empty""";
        } else if (di<ContactsCubit>().phoneController!.text.length != 11) {
          return "invalid phone number";
        }
        return null;
      },
    );
  }
}
