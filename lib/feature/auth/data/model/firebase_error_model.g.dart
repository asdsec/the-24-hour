// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseErrorModel _$FirebaseErrorModelFromJson(Map<String, dynamic> json) =>
    FirebaseErrorModel(
      error: json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FirebaseErrorModelToJson(FirebaseErrorModel instance) =>
    <String, dynamic>{
      'error': instance.error?.toJson(),
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      code: json['code'] as int?,
      message: $enumDecodeNullable(_$FirebaseErrorsEnumMap, json['message']),
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'code': instance.code,
      'message': _$FirebaseErrorsEnumMap[instance.message],
    };

const _$FirebaseErrorsEnumMap = {
  FirebaseErrors.invalidPassword: 'INVALID_PASSWORD',
  FirebaseErrors.emailNotFound: 'EMAIL_NOT_FOUND',
};
