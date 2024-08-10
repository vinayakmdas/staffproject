// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domainmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DomainmodelAdapter extends TypeAdapter<Domainmodel> {
  @override
  final int typeId = 1;

  @override
  Domainmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Domainmodel(
      domain: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Domainmodel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.domain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DomainmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
