// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yacht.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YachtAdapter extends TypeAdapter<Yacht> {
  @override
  final typeId = 1;
  
  @override
  Yacht read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Yacht(
      name: fields[0] as String,
      imo: fields[1] as int,
      length: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Yacht obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imo)
      ..writeByte(2)
      ..write(obj.length);
  }
}
