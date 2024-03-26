import 'dart:io';

class UploadFileToStorageParams {
  final String collectionName;
  final File file;

  UploadFileToStorageParams({
    required this.collectionName,
    required this.file,
  });
}
