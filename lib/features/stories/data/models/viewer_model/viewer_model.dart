import 'package:freezed_annotation/freezed_annotation.dart';

part 'viewer_model.freezed.dart';
part 'viewer_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ViewerModel with _$ViewerModel {
  factory ViewerModel({
    String? id,
    String? phoneNumber,
    String? dateTime,
  }) = _ViewerModel;

  factory ViewerModel.fromJson(Map<String, dynamic> json) =>
      _$ViewerModelFromJson(json);
}
