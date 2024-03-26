import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class NoItemsFounded extends StatelessWidget {
  final String text;
  final IconData icon;
  const NoItemsFounded({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: AppSize.s100,
          color: AppColors.grey.withOpacity(0.4),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: FontSize.s13,
                color: AppColors.grey.withOpacity(0.5),
                height: 1.5,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
