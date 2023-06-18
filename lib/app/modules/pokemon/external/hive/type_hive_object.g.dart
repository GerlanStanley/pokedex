// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeHiveObjectAdapter extends TypeAdapter<TypeHiveObject> {
  @override
  final int typeId = 2;

  @override
  TypeHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeHiveObject(
      name: fields[0] as String,
      image: fields[1] as String,
      colorLight: fields[2] as int,
      colorDark: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TypeHiveObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.colorLight)
      ..writeByte(3)
      ..write(obj.colorDark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
