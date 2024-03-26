import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:nuntius/core/shared_widgets/circle_indicator.dart';
import 'package:nuntius/core/shared_widgets/text.dart';
import 'package:nuntius/core/utils/app_colors.dart';
import 'package:nuntius/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatefulWidget {
  final String videoUrl;
  const VideoMessage({super.key, required this.videoUrl});

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;
  Future<void>? _future;

  Future<void> initVideoPlayer() async {
    await videoPlayerController!.initialize();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setState(() {
          debugPrint(videoPlayerController!.value.aspectRatio.toString());
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController!,
            aspectRatio: videoPlayerController!.value.aspectRatio,
            autoPlay: false,
            looping: false,
            materialProgressColors:
                ChewieProgressColors(bufferedColor: Colors.white),
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LargeHeadText(
                    text: errorMessage,
                    color: AppColors.white,
                    maxLines: 7,
                  ),
                ),
              );
            },
          );
        });
        chewieController!.addListener(() {
          if (!chewieController!.isFullScreen) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
          }
        });
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DefaultCacheManager defaultCacheManager = DefaultCacheManager();
      videoPlayerController =
          await CachedVideoControllerService(defaultCacheManager)
              .getControllerForVideo(widget.videoUrl);
      _future = initVideoPlayer();
    });

    super.initState();
  }

  @override
  void dispose() {
    if (videoPlayerController != null) videoPlayerController!.dispose();
    if (chewieController != null) chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h180,
      width: AppWidth.w300,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppHeight.h2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s20),
          child: _future != null && chewieController != null
              ? FutureBuilder(
                  future: _future,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (videoPlayerController!.value.isInitialized) {
                      return Chewie(
                        controller: chewieController!,
                      );
                    } else {
                      return const Center(child: CustomCircleIndicator());
                    }
                  },
                )
              : const Center(child: CustomCircleIndicator()),
        ),
      ),
    );
  }
}

abstract class VideoControllerService {
  Future<VideoPlayerController> getControllerForVideo(String videoUrl);
}

class CachedVideoControllerService extends VideoControllerService {
  final BaseCacheManager _cacheManager;

  CachedVideoControllerService(this._cacheManager);

  @override
  Future<VideoPlayerController> getControllerForVideo(String videoUrl) async {
    final fileInfo = await _cacheManager.getFileFromCache(videoUrl);

    if (fileInfo == null) {
      debugPrint('[VideoControllerService]: No video in cache');

      debugPrint('[VideoControllerService]: Saving video to cache');
      unawaited(_cacheManager.downloadFile(videoUrl));

      return VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    } else {
      debugPrint('[VideoControllerService]: Loading video from cache');
      return VideoPlayerController.file(fileInfo.file);
    }
  }
}
