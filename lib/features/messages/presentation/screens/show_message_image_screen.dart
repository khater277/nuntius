import 'package:cached_network_image/cached_network_image.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_fonts.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowMessageImageScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String date;
  const ShowMessageImageScreen(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeHeadText(text: name),
            SizedBox(height: AppHeight.h2),
            PrimaryText(
              text: DateFormat('d MMM , yyyy')
                  .add_jm()
                  .format(DateTime.parse(date).toLocal()),
              size: FontSize.s12,
              color: AppColors.grey,
            ),
          ],
        ),
        titleSpacing: 0,
        leading: const CustomBackButton(),
      ),
      body: Center(child: CachedNetworkImage(imageUrl: imageUrl)),
    );
  }
}
