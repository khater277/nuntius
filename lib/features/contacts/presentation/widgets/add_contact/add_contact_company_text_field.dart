import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_text_field_and_title.dart';
import 'package:flutter/material.dart';

class AddContactCompanyTextField extends StatelessWidget {
  const AddContactCompanyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return AddContactTextFieldAndTitle(
      controller: di<ContactsCubit>().companyController!,
      title: 'Company',
      hint: 'company..',
      inputType: TextInputType.text,
      icon: IconBroken.Work,
    );
  }
}
