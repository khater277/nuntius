// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'call_status.g.dart';

@HiveType(typeId: 101)
enum CallStatus {
  @JsonKey(name: 'inComing')
  @HiveField(0)
  inComing,
  @JsonKey(name: 'outComing')
  @HiveField(1)
  outComing,
  @JsonKey(name: 'inComingNoResponse')
  @HiveField(2)
  inComingNoResponse,
  @JsonKey(name: 'outComingNoResponse')
  @HiveField(3)
  outComingNoResponse,
}
