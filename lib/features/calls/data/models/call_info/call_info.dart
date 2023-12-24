// ignore_for_file: invalid_annotation_target

import 'package:nuntius_/features/calls/data/models/call_model/call_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_info.freezed.dart';
part 'call_info.g.dart';

@freezed
class CallInfo with _$CallInfo {
  factory CallInfo({
    CallModel? callModel,
    String? name,
    String? image,
  }) = _CallInfo;

  factory CallInfo.fromJson(Map<String, dynamic> json) =>
      _$CallInfoFromJson(json);
}
