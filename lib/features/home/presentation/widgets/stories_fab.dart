import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class StoriesFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tag;
  const StoriesFab(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s40,
      height: AppSize.s40,
      child: FloatingActionButton(
        heroTag: tag,
        onPressed: onPressed,
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          icon,
          color: AppColors.white,
          size: AppSize.s18,
        ),
      ),
    );
  }
}
