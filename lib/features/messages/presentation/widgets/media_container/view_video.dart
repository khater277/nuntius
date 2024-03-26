import 'package:chewie/chewie.dart';
import 'package:nuntius/app/injector.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:nuntius/features/messages/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({
    super.key,
  });

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  Future<void>? _future;

  Future<void> initVideoPlayer() async {
    await videoPlayerController.initialize();
  }

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.file(di<MessagesCubit>().file!);
    _future = initVideoPlayer();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await videoPlayerController.initialize();
    // });
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 9,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SecondaryText(
              text: errorMessage,
              color: AppColors.white,
            ),
          ),
        );
      },
    );
    chewieController.addListener(() {
      if (!chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppHeight.h2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSize.s20),
        child: _future != null
            ? FutureBuilder(
                future: _future,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (videoPlayerController.value.isInitialized) {
                    return Chewie(
                      controller: chewieController,
                    );
                  } else {
                    return const Center(child: CustomCircleIndicator());
                  }
                },
              )
            : const Center(child: CustomCircleIndicator()),
      ),
    );
  }
}
