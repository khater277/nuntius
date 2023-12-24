import 'package:dartz/dartz.dart';
import 'package:nuntius_/core/errors/failures.dart';

abstract class EditProfileRepository {
  Future<Either<Failure, void>> updateProfileData(
      {required Map<String, dynamic> data});
}
