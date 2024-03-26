import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:nuntius/core/errors/failures.dart';
import 'package:nuntius/features/calls/domain/parameters/add_new_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/generate_token_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_call_params.dart';
import 'package:nuntius/features/calls/domain/parameters/update_in_call_params.dart';
import 'package:nuntius/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';

abstract class CallsRepository {
  Future<Either<Failure, AgoraTokenModel>> generateToken(
      {required GenerateTokenParams generateTokenParams});

  Future<Either<Failure, void>> addNewCall(
      {required AddNewCallParams addNewCallParams});

  Future<Either<Failure, void>> updateCall(
      {required UpdateCallParams updateCallParams});

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCalls();

  Future<Either<Failure, void>> updateInCallUsecase(
      UpdateInCallParams updateInCallParams);
}
