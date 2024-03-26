import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntius/features/auth/data/models/user_data/user_data.dart';

part 'all_users_model.freezed.dart';
part 'all_users_model.g.dart';

@freezed
@HiveType(typeId: 1)
class AllUsersModel with _$AllUsersModel {
  factory AllUsersModel({
    @HiveField(0) List<UserData>? users,
  }) = _AllUsersModel;

  factory AllUsersModel.fromJson(Map<String, dynamic> json) =>
      _$AllUsersModelFromJson(json);
}
