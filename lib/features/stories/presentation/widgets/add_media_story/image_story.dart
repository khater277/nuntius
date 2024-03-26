import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';

class ImageStory extends StatelessWidget {
  const ImageStory({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    if (di<StoriesCubit>().width != 0.0 && di<StoriesCubit>().height != 0.0) {
      return SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: Image.file(
          di<StoriesCubit>().storyFile!,
          fit: di<StoriesCubit>().width >= deviceWidth
              ? BoxFit.fitWidth
              : di<StoriesCubit>().height >= deviceHeight
                  ? BoxFit.fitHeight
                  : null,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
