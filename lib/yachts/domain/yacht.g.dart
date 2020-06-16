// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yacht.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YachtAdapter extends TypeAdapter<Yacht> {
  @override
  final typeId = 0;

  @override
  Yacht read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Yacht(
      id: fields[0] as String,
      name: fields[1] as String,
      imo: fields[2] as int,
      length: fields[3] as double,
      buildDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Yacht obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imo)
      ..writeByte(3)
      ..write(obj.length)
      ..writeByte(4)
      ..write(obj.buildDate);
  }
}
