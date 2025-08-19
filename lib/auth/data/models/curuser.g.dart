// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curuser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurUserAdapter extends TypeAdapter<CurUser> {
  @override
  final int typeId = 0;

  @override
  CurUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurUser(
      token: fields[0] as String,
      userId: fields[1] as String,
      name: fields[2] as String,
      email: fields[3] as String,
      photo: fields[4] as String,
      phoneNumber: fields[5] as String,
      role: fields[6] as String,
      nationalId: fields[7] as String,
      vehicleType: fields[8] as String?,
      online: fields[9] as bool,
      coord: (fields[10] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, CurUser obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.photo)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.nationalId)
      ..writeByte(8)
      ..write(obj.vehicleType)
      ..writeByte(9)
      ..write(obj.online)
      ..writeByte(10)
      ..write(obj.coord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
