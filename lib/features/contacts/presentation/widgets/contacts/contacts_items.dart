import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/contact_view.dart';
import 'package:flutter/material.dart';

class ContactsItems extends StatelessWidget {
  const ContactsItems({
    super.key,
    required this.users,
  });

  final List<UserData> users;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ContactView(user: users[index]),
      ),
    );
  }
}
