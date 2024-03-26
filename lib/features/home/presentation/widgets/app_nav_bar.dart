import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';

class AppBottomNavBar extends StatelessWidget {
  final int index;
  const AppBottomNavBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppHeight.h3),
      child: DotNavigationBar(
        curve: Curves.fastOutSlowIn,
        currentIndex: index,
        onTap: (index) => di<HomeCubit>().changeNavBar(index: index),
        marginR: EdgeInsets.symmetric(horizontal: AppWidth.w20),
        dotIndicatorColor: Colors.transparent,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.white.withOpacity(0.7),
        backgroundColor: AppColors.lightBlack,
        itemPadding: EdgeInsets.only(
          left: AppWidth.w20,
          right: AppWidth.w20,
          top: AppHeight.h5,
        ),
        borderRadius: AppSize.s50,
        items: [
          DotNavigationBarItem(
            icon: Icon(
              IconBroken.Chat,
              size: AppSize.s20,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              IconBroken.Camera,
              size: AppSize.s20,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              IconBroken.Call,
              size: AppSize.s20,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              IconBroken.User1,
              size: AppSize.s20,
            ),
          ),
        ],
      ),
    );
  }
}
