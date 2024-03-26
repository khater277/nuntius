import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';

abstract class FirebaseMedia {
  Future<Either<String, Stream<TaskSnapshot>>> uploadFileToStorage(
      {required UploadFileToStorageParams uploadFileToStorageParams});
}

class FirebaseMediaImpl implements FirebaseMedia {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  @override
  Future<Either<String, Stream<TaskSnapshot>>> uploadFileToStorage(
      {required UploadFileToStorageParams uploadFileToStorageParams}) async {
    final reference = _storage.ref(
        "${uploadFileToStorageParams.collectionName}/${Uri.file(uploadFileToStorageParams.file.path).pathSegments.last}");

    try {
      final result = await reference.getDownloadURL();
      return Left(result);
    } on FirebaseException {
      final result = _storage
          .ref(
              "${uploadFileToStorageParams.collectionName}/${Uri.file(uploadFileToStorageParams.file.path).pathSegments.last}")
          .putFile(uploadFileToStorageParams.file)
          .snapshotEvents;
      return Right(result);
    }
  }
}
