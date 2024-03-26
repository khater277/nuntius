import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/user_image.dart';
import 'package:nuntius/features/contacts/presentation/widgets/contacts/user_name_and_phone_number.dart';
import 'package:nuntius/features/messages/presentation/screens/messages_screen.dart';
import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  final UserData user;
  final bool fromSearch;
  const ContactView({super.key, required this.user, this.fromSearch = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.h10),
      child: GestureDetector(
        onTap: () => Go.to(
            context: context, screen: MessagesScreen(phoneNumber: user.phone!)),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            children: [
              UserImage(image: user.image!),
              SizedBox(
                width: AppWidth.w10,
              ),
              UserNameAndPhoneNumber(user: user),
              SizedBox(
                width: AppWidth.w10,
              ),
              if (!fromSearch)
                Icon(
                  IconBroken.Arrow___Right_2,
                  size: AppSize.s17,
                  color: Colors.grey,
                )
            ],
          ),
        ),
      ),
    );
  }
}
