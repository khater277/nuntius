import 'package:freezed_annotation/freezed_annotation.dart';

part 'agora_token_model.freezed.dart';
part 'agora_token_model.g.dart';

@freezed
class AgoraTokenModel with _$AgoraTokenModel {
  factory AgoraTokenModel({
    String? rtcToken,
  }) = _AgoraTokenModel;

  factory AgoraTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenModelFromJson(json);
}
