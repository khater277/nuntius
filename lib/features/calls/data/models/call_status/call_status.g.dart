// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallStatusAdapter extends TypeAdapter<CallStatus> {
  @override
  final int typeId = 101;

  @override
  CallStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CallStatus.inComing;
      case 1:
        return CallStatus.outComing;
      case 2:
        return CallStatus.inComingNoResponse;
      case 3:
        return CallStatus.outComingNoResponse;
      default:
        return CallStatus.inComing;
    }
  }

  @override
  void write(BinaryWriter writer, CallStatus obj) {
    switch (obj) {
      case CallStatus.inComing:
        writer.writeByte(0);
        break;
      case CallStatus.outComing:
        writer.writeByte(1);
        break;
      case CallStatus.inComingNoResponse:
        writer.writeByte(2);
        break;
      case CallStatus.outComingNoResponse:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
