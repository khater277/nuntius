import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_text_field_and_title.dart';
import 'package:flutter/material.dart';

class AddContactFirstAndLastNamesTextFields extends StatelessWidget {
  const AddContactFirstAndLastNamesTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AddContactTextFieldAndTitle(
            controller: di<ContactsCubit>().firstNameController!,
            title: "First name",
            hint: 'first name..',
            inputType: TextInputType.name,
            icon: IconBroken.Profile,
            validator: (value) {
              if (di<ContactsCubit>().firstNameController!.text.isEmpty) {
                return """can't be empty""";
              }
              return null;
            },
          ),
        ),
        SizedBox(width: AppWidth.w10),
        Expanded(
          child: AddContactTextFieldAndTitle(
            controller: di<ContactsCubit>().lastNameController!,
            title: "Last name",
            hint: 'last name..',
            inputType: TextInputType.name,
            icon: IconBroken.Profile,
            validator: (value) {
              if (di<ContactsCubit>().lastNameController!.text.isEmpty) {
                return """can't be empty""";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
