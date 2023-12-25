import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/features/stories/cubit/stories_cubit.dart';
import 'package:flutter/material.dart';

class ImageStory extends StatelessWidget {
  const ImageStory({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<StoriesCubit, StoriesState>(
      builder: (context, state) {
        if (di<StoriesCubit>().width != 0.0 &&
            di<StoriesCubit>().height != 0.0) {
          return SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: di<StoriesCubit>().storyFile != null
                ? Image.file(
                    di<StoriesCubit>().storyFile!,
                    fit: di<StoriesCubit>().width >= deviceWidth
                        ? BoxFit.fitWidth
                        : di<StoriesCubit>().height >= deviceHeight
                            ? BoxFit.fitHeight
                            : null,
                  )
                : null,
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
