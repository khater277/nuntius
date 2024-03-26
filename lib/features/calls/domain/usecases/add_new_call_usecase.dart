// Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
//     getCalls();

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';

class AddNewCallUsecase implements BaseUseCase<void, AddNewCallParams> {
  final CallsRepository callsRepository;

  AddNewCallUsecase({required this.callsRepository});

  @override
  Future<Either<Failure, void>> call(AddNewCallParams addNewCallParams) {
    return callsRepository.addNewCall(addNewCallParams: addNewCallParams);
  }
}
