// Future<Either<Failure, void>> updateCall({
// required String callId,
// required String friendPhoneNumber,
// });

// Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
//     getCalls();

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';

class UpdateCallUsecase implements BaseUseCase<void, UpdateCallParams> {
  final CallsRepository callsRepository;

  UpdateCallUsecase({required this.callsRepository});

  @override
  Future<Either<Failure, void>> call(UpdateCallParams updateCallParams) {
    return callsRepository.updateCall(updateCallParams: updateCallParams);
  }
}
