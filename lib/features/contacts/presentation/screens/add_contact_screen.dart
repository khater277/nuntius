import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/contacts/cubit/contacts_cubit.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_app_bar.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_company_text_field.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_email_text_field.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_first_and_last_names_text_fields.dart';
import 'package:nuntius/features/contacts/presentation/widgets/add_contact/add_contact_phone_text_field.dart';

class AddContactsScreen extends StatefulWidget {
  const AddContactsScreen({super.key});

  @override
  State<AddContactsScreen> createState() => _AddContactsScreenState();
}

class _AddContactsScreenState extends State<AddContactsScreen> {
  @override
  void initState() {
    di<ContactsCubit>().initControllers();
    super.initState();
  }

  @override
  void dispose() {
    di<ContactsCubit>().disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddContactAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
        child: SingleChildScrollView(
          child: Form(
            key: di<ContactsCubit>().formKey,
            child: Column(
              children: [
                SizedBox(height: AppHeight.h10),
                const AddContactFirstAndLastNamesTextFields(),
                SizedBox(height: AppHeight.h15),
                const AddContactPhoneTextField(),
                SizedBox(height: AppHeight.h15),
                const AddContactEmailTextField(),
                SizedBox(height: AppHeight.h15),
                const AddContactCompanyTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
