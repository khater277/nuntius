import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/config/navigation.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/core/utils/icons_broken.dart';
import 'package:nuntius/features/home/cubit/home_cubit.dart';
import 'package:nuntius/features/home/presentation/widgets/stories_fab.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/screens/add_text_story_screen.dart';
import 'package:flutter/material.dart';

class StoriesFloatingButtons extends StatefulWidget {
  const StoriesFloatingButtons({super.key});

  @override
  State<StoriesFloatingButtons> createState() => _StoriesFloatingButtonsState();
}

class _StoriesFloatingButtonsState extends State<StoriesFloatingButtons> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current.maybeWhen(
        changeNavBar: (index) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.maybeWhen(
          changeNavBar: (index) => this.index = index,
          orElse: () {},
        );
      },
      builder: (context, state) {
        return index == 1
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoriesFab(
                    onPressed: () => Go.to(
                        context: context, screen: const AddTextStoryScreen()),
                    icon: IconBroken.Edit,
                    tag: "btn1",
                  ),
                  SizedBox(height: AppHeight.h6),
                  StoriesFab(
                    onPressed: () => di<StoriesCubit>()
                        .pickStoryMedia(type: MessageType.image),
                    icon: IconBroken.Image,
                    tag: "btn2",
                  ),
                  SizedBox(height: AppHeight.h6),
                  StoriesFab(
                    onPressed: () => di<StoriesCubit>()
                        .pickStoryMedia(type: MessageType.video),
                    icon: IconBroken.Video,
                    tag: "btn3",
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
