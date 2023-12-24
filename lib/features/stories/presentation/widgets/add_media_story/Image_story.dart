import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:flutter/material.dart';

class ImageStory extends StatelessWidget {
  const ImageStory({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    if (StoriesCubit.get(context).width != 0.0 &&
        StoriesCubit.get(context).height != 0.0) {
      return SizedBox(
        width: deviceWidth,
        height: deviceHeight,
        child: StoriesCubit.get(context).storyFile != null
            ? Image.file(
                StoriesCubit.get(context).storyFile!,
                fit: StoriesCubit.get(context).width >= deviceWidth
                    ? BoxFit.fitWidth
                    : StoriesCubit.get(context).height >= deviceHeight
                        ? BoxFit.fitHeight
                        : null,
              )
            : null,
      );
    } else {
      return const SizedBox();
    }
  }
}
