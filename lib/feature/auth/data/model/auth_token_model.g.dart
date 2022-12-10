// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthTokenModelAdapter extends TypeAdapter<AuthTokenModel> {
  @override
  final int typeId = 0;

  @override
  AuthTokenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthTokenModel(
      localId: fields[0] as String,
      email: fields[1] as String,
      idToken: fields[2] as String,
      refreshToken: fields[3] as String,
      expiresIn: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AuthTokenModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.localId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.idToken)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.expiresIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTokenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenModel _$AuthTokenModelFromJson(Map<String, dynamic> json) =>
    AuthTokenModel(
      localId: json['localId'] as String,
      email: json['email'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn:
          const ExpireTimeConverter().fromJson(json['expiresIn'] as Object),
    );

Map<String, dynamic> _$AuthTokenModelToJson(AuthTokenModel instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'email': instance.email,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': const ExpireTimeConverter().toJson(instance.expiresIn),
    };
