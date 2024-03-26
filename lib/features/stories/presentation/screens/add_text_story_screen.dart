import 'package:flutter/material.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/back_button.dart';
import 'package:nuntius/core/utils/app_enums.dart';
import 'package:nuntius/features/stories/cubit/stories_cubit.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_text_story/send_story_button.dart';
import 'package:nuntius/features/stories/presentation/widgets/add_text_story/story_text_field.dart';

class AddTextStoryScreen extends StatefulWidget {
  const AddTextStoryScreen({super.key});

  @override
  State<AddTextStoryScreen> createState() => _AddTextStoryScreenState();
}

class _AddTextStoryScreenState extends State<AddTextStoryScreen> {
  @override
  void initState() {
    di<StoriesCubit>().initAddTextStory();
    super.initState();
  }

  @override
  void dispose() {
    di<StoriesCubit>().disposeAddTextStory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: const CustomBackButton()),
        body: const StoryTextField(),
        floatingActionButton: const SendStoryButton(
          storyType: MessageType.text,
        ),
      ),
    );
  }
}
