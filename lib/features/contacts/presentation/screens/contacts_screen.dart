import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/sliver_scrollable_view.dart';
import 'package:nuntius/core/shared_widgets/snack_bar.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/add_new_contact.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/contacts_items.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/no_contacts_founded.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => current.maybeWhen(
        getContacts: () => true,
        getContactsError: () => true,
        getContactsLoading: () => true,
        orElse: () => false,
      ),
      buildWhen: (previous, current) => current.maybeWhen(
        getContacts: () => true,
        getContactsError: () => true,
        getContactsLoading: () => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          getContactsError: () => errorSnackBar(
              context: context,
              errorMsg: "there is some conflicts to get your contacts."),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          getContactsLoading: () =>
              const Center(child: CustomCircleIndicator()),
          getContactsError: () =>
              const Center(child: LargeHeadText(text: "ERROR")),
          orElse: () => SliverScrollableView(
            isScrollable: di<HomeCubit>().users.isNotEmpty,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppHeight.h16),
                const NewContact(),
                SizedBox(height: AppHeight.h16),
                const LargeHeadText(
                  text: "Contacts",
                  letterSpacing: 2,
                ),
                if (di<HomeCubit>().users.isNotEmpty)
                  ContactsItems(users: di<HomeCubit>().users)
                else
                  const NoContactsFounded(),
              ],
            ),
          ),
        );
      },
    );
  }
}
