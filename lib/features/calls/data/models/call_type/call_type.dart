// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'call_type.g.dart';

@HiveType(typeId: 100)
enum CallType {
  @JsonKey(name: 'voice')
  @HiveField(0)
  voice,
  @JsonKey(name: 'video')
  @HiveField(1)
  video,
}
