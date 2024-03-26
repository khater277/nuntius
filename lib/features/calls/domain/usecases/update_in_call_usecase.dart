import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/calls/domain/parameters/update_in_call_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';

class UpdateInCallUsecase implements BaseUseCase<void, UpdateInCallParams> {
  final CallsRepository callsRepository;

  UpdateInCallUsecase({required this.callsRepository});
  @override
  Future<Either<Failure, void>> call(UpdateInCallParams updateInCallParams) {
    return callsRepository.updateInCallUsecase(updateInCallParams);
  }
}
