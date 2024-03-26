// ignore_for_file: invalid_annotation_target

import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/features/calls/data/models/call_model/call_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_info.freezed.dart';
part 'call_info.g.dart';

@freezed
@HiveType(typeId: 6)
class CallInfo with _$CallInfo {
  factory CallInfo({
    @HiveField(0) CallModel? callModel,
    @HiveField(1) String? name,
    @HiveField(2) String? image,
  }) = _CallInfo;

  factory CallInfo.fromJson(Map<String, dynamic> json) =>
      _$CallInfoFromJson(json);
}
