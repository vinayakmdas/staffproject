// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackendModelAdapter extends TypeAdapter<BackendModel> {
  @override
  final int typeId = 6;

  @override
  BackendModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackendModel(
      backend: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BackendModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.backend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackendModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
