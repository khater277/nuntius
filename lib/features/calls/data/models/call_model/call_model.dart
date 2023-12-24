// ignore_for_file: invalid_annotation_target

import 'package:nuntius_/core/utils/app_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
class CallModel with _$CallModel {
  factory CallModel({
    String? callId,
    String? phoneNumber,
    CallType? callType,
    CallStatus? callStatus,
    String? dateTime,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);
}
