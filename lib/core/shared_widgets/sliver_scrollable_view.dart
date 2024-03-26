import 'package:nuntius/core/shared_widgets/sliver_app_bar.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class SliverScrollableView extends StatelessWidget {
  final Widget child;
  final bool isScrollable;
  const SliverScrollableView(
      {super.key, required this.child, required this.isScrollable});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const CustomSliverAppBar(),
        if (isScrollable)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                right: AppWidth.w10,
                left: AppWidth.w10,
                top: AppHeight.h5,
              ),
              child: child,
            ),
          )
        else
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.only(
                right: AppWidth.w10,
                left: AppWidth.w10,
                top: AppHeight.h5,
              ),
              child: child,
            ),
          )
      ],
    );
  }
}
