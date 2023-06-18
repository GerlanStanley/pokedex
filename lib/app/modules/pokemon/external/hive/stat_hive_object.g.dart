// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatHiveObjectAdapter extends TypeAdapter<StatHiveObject> {
  @override
  final int typeId = 3;

  @override
  StatHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatHiveObject(
      name: fields[0] as String,
      baseStat: fields[1] as int,
      effort: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StatHiveObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.baseStat)
      ..writeByte(2)
      ..write(obj.effort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
