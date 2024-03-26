import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/auth/domain/parameters/no_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';

class GetCallsUsecase
    implements
        BaseUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final CallsRepository callsRepository;

  GetCallsUsecase({required this.callsRepository});

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams noParams) {
    return callsRepository.getCalls();
  }
}
