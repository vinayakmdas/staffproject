// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompleteModelAdapter extends TypeAdapter<CompleteModel> {
  @override
  final int typeId = 5;

  @override
  CompleteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompleteModel(
      staffname: fields[0] as String,
      domainname: fields[1] as String,
      project: fields[2] as String,
      calendarDate: fields[3] as DateTime,
      fileproperties: fields[4] as String?,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompleteModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.staffname)
      ..writeByte(1)
      ..write(obj.domainname)
      ..writeByte(2)
      ..write(obj.project)
      ..writeByte(3)
      ..write(obj.calendarDate)
      ..writeByte(4)
      ..write(obj.fileproperties)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompleteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
