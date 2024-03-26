import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/home/presentation/screens/home_screen.dart';
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
          ? Go.offAll(
              context: context, screen: const HomeScreen(fromLogout: false))
          : Go.back(context: context),
      icon: Icon(
        IconBroken.Arrow___Left_2,
        size: AppSize.s18,
      ),
    );
  }
}
