// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallTypeAdapter extends TypeAdapter<CallType> {
  @override
  final int typeId = 100;

  @override
  CallType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CallType.voice;
      case 1:
        return CallType.video;
      default:
        return CallType.voice;
    }
  }

  @override
  void write(BinaryWriter writer, CallType obj) {
    switch (obj) {
      case CallType.voice:
        writer.writeByte(0);
        break;
      case CallType.video:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
