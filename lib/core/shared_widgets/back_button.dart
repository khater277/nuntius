import 'package:nuntius_/config/navigation.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final bool isMessagesScreen;
  const CustomBackButton({
    super.key,
    this.isMessagesScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => isMessagesScreen
          ? Go.offAll(context: context, screen: const HomeScreen())
          : Go.back(context: context),
      icon: Icon(
        IconBroken.Arrow___Left_2,
        size: AppSize.s18,
      ),
    );
  }
}
