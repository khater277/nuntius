import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/upload_file_to_storage_params.dart';
import 'package:nuntius/features/auth/domain/repository/auth_repository.dart';

class UploadFileToStorageUsecase
    implements
        BaseUseCase<Either<String, Stream<TaskSnapshot>>?,
            UploadFileToStorageParams> {
  final AuthRepository authRepository;

  UploadFileToStorageUsecase({required this.authRepository});
  @override
  Future<Either<Failure, Either<String, Stream<TaskSnapshot>>?>> call(
      UploadFileToStorageParams uploadFileToStorageParams) {
    return authRepository.uploadFileToStorage(
        uploadFileToStorageParams: uploadFileToStorageParams);
  }
}
