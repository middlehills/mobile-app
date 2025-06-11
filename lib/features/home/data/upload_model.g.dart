// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UploadModelAdapter extends TypeAdapter<UploadModel> {
  @override
  final int typeId = 1;

  @override
  UploadModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UploadModel(
      itemName: fields[0] as String,
      quantity: fields[1] as String,
      amount: fields[2] as int,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UploadModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.itemName)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UploadModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
