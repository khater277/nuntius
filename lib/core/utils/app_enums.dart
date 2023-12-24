// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

enum CallType {
  @JsonKey(name: 'voice')
  voice,
  @JsonKey(name: 'video')
  video,
}

enum CallStatus {
  @JsonKey(name: 'inComing')
  inComing,
  @JsonKey(name: 'outComing')
  outComing,
  @JsonKey(name: 'inComingNoResponse')
  inComingNoResponse,
  @JsonKey(name: 'outComingNoResponse')
  outComingNoResponse,
}

enum MessageType {
  deleted,
  text,
  image,
  video,
  doc,
}
