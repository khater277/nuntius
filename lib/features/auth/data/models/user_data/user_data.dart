import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
@HiveType(typeId: 0)
class UserData with _$UserData {
  factory UserData({
    @HiveField(0) String? token,
    @HiveField(1) String? name,
    @HiveField(2) String? uId,
    @HiveField(3) String? phone,
    @HiveField(4) String? image,
    @HiveField(5) bool? inCall,
    @HiveField(6) Map<String, String>? contacts,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
