// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

enum MessageType {
  deleted,
  text,
  image,
  video,
  doc,
}

enum NotificationType {
  @JsonKey(name: 'message')
  message,
  @JsonKey(name: 'receiveCall')
  receiveCall,
  @JsonKey(name: 'cancelCall')
  cancelCall,
  @JsonKey(name: 'joinCall')
  joinCall,
}
