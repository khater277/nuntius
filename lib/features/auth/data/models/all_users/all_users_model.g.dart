// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_users_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllUsersModelAdapter extends TypeAdapter<AllUsersModel> {
  @override
  final int typeId = 1;

  @override
  AllUsersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllUsersModel(
      users: (fields[0] as List?)?.cast<UserData>(),
    );
  }

  @override
  void write(BinaryWriter writer, AllUsersModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.users);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllUsersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllUsersModelImpl _$$AllUsersModelImplFromJson(Map<String, dynamic> json) =>
    _$AllUsersModelImpl(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AllUsersModelImplToJson(_$AllUsersModelImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
