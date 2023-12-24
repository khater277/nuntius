import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/contacts/presentation/screens/add_contact_screen.dart';
import 'package:flutter/material.dart';

class NewContact extends StatelessWidget {
  const NewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Go.to(context: context, screen: const AddContactsScreen());
      },
      child: Row(
        children: [
          Container(
            width: AppWidth.w45,
            height: AppHeight.h40,
            decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(AppSize.s5)),
            child: Icon(
              IconBroken.Add_User,
              size: AppSize.s18,
            ),
          ),
          SizedBox(
            width: AppWidth.w8,
          ),
          LargeHeadText(
            text: "New contact",
            size: FontSize.s15,
          ),
        ],
      ),
    );
  }
}
