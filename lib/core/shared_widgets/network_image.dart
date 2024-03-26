import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  const CustomNetworkImage(
      {super.key, required this.imageUrl, required this.fit});

  Future<bool> checkInternet() async {
    bool? result;
    InternetConnectionChecker().hasConnection.then((value) => result = value);
    return result!;
    // return await InternetConnectionChecker().hasConnection;
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, s) => SizedBox(
        height: AppHeight.h200,
        child: Center(
          child:
              CustomCircleIndicator(color: AppColors.white, size: AppSize.s25),
        ),
      ),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) {
        return Center(
          child: SizedBox(
            height: AppHeight.h200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  IconBroken.Danger,
                  size: AppSize.s50,
                  color: AppColors.grey,
                ),
                const SecondaryText(text: "connection error")
              ],
            ),
          ),
        );
      },
    );
  }
}
