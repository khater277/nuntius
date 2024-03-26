// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/features/calls/data/models/call_status/call_status.dart';
import 'package:nuntius/features/calls/data/models/call_type/call_type.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
@HiveType(typeId: 5)
class CallModel with _$CallModel {
  factory CallModel({
    @HiveField(0) String? callId,
    @HiveField(1) String? phoneNumber,
    @HiveField(2) CallType? callType,
    @HiveField(3) CallStatus? callStatus,
    @HiveField(4) String? dateTime,
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);
}
