import 'dart:async';
import 'dart:io';

import 'package:nuntius_/app/injector.dart';
import 'package:nuntius_/core/shared_widgets/text.dart';
import 'package:nuntius_/core/utils/app_colors.dart';
import 'package:nuntius_/core/utils/app_fonts.dart';
import 'package:nuntius_/core/utils/app_values.dart';
import 'package:nuntius_/core/utils/icons_broken.dart';
import 'package:nuntius_/features/messages/cubit/messages_cubit.dart';
import 'package:nuntius_/features/messages/data/models/message/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';

class DocMessage extends StatefulWidget {
  const DocMessage({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  State<DocMessage> createState() => _DocMessageState();
}

class _DocMessageState extends State<DocMessage> {
  DefaultCacheManager defaultCacheManager = DefaultCacheManager();
  Future<File> getFile() async {
    return await CachedFileControllerService(defaultCacheManager)
        .getFile(widget.message.media!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => di<MessagesCubit>().openDocMessage(
        url: widget.message.media!,
        id: widget.message.messageId!,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            IconBroken.Document,
            color: AppColors.white,
            size: AppSize.s20,
          ),
          SizedBox(width: AppWidth.w4),
          Flexible(
            fit: FlexFit.loose,
            child: SmallHeadText(
              text: widget.message.message!,
              size: FontSize.s13,
              maxLines: 1000000,
              isUnderLine: true,
            ),
          ),
          SizedBox(width: AppWidth.w5),
          SecondaryText(
            text: DateFormat.jm()
                .format(DateTime.parse(widget.message.date!).toLocal()),
            color: AppColors.grey,
            size: FontSize.s10,
          )
        ],
      ),
    );
  }
}

abstract class FileService {
  Future<File> getFile(String fileUrl);
}

class CachedFileControllerService extends FileService {
  final BaseCacheManager _cacheManager;

  CachedFileControllerService(this._cacheManager);

  @override
  Future<File> getFile(String fileUrl) async {
    final fileInfo = await _cacheManager.getFileFromCache(fileUrl);

    if (fileInfo == null) {
      print('[FileControllerService]: No file in cache');

      print('[FileControllerService]: Saving file to cache');
      await _cacheManager.downloadFile(fileUrl);
      // unawaited(_cacheManager.downloadFile(fileUrl));
      return _cacheManager.getSingleFile(fileUrl);
    } else {
      print('[FileControllerService]: Loading file from cache');
      return _cacheManager.getSingleFile(fileUrl);
    }
  }
}
