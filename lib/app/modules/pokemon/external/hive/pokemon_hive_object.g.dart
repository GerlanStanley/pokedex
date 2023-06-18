// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonHiveObjectAdapter extends TypeAdapter<PokemonHiveObject> {
  @override
  final int typeId = 1;

  @override
  PokemonHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonHiveObject(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as int,
      weight: fields[3] as int,
      baseExperience: fields[4] as int,
      image: fields[5] as String,
      types: (fields[6] as List).cast<TypeHiveObject>(),
      abilities: (fields[7] as List).cast<String>(),
      stats: (fields[8] as List).cast<StatHiveObject>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonHiveObject obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.baseExperience)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.types)
      ..writeByte(7)
      ..write(obj.abilities)
      ..writeByte(8)
      ..write(obj.stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
