// Future<Either<Failure, void>> addNewCall({
//   required String friendPhoneNumber,
//   required String callId,
//   required CallType callType,
// });

// Future<Either<Failure, void>> updateCall({
//   required String callId,
//   required String friendPhoneNumber,
// });

// Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
//     getCalls();

import 'package:dartz/dartz.dart';
import 'package:nuntius/core/base_usecase/base_usecase.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/calls/domain/parameters/generate_token_params.dart';
import 'package:nuntius/features/calls/domain/repositories/calls_repository.dart';
import 'package:nuntius/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

class GenerateTokenUsecase
    implements BaseUseCase<AgoraTokenModel, GenerateTokenParams> {
  final CallsRepository callsRepository;

  GenerateTokenUsecase({required this.callsRepository});
  @override
  Future<Either<Failure, AgoraTokenModel>> call(
      GenerateTokenParams generateTokenParams) {
    return callsRepository.generateToken(
        generateTokenParams: generateTokenParams);
  }
}
