import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_24_hour/feature/auth/domain/entity/auth_token.dart';
import 'package:the_24_hour/product/constant/hive_constants.dart';
import 'package:the_24_hour/product/error/exception.dart';

part 'auth_token_model.g.dart';

@immutable
@JsonSerializable()
@HiveType(typeId: HiveConstants.authTokenModelTypeId)
class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.localId,
    required super.email,
    required super.idToken,
    required super.refreshToken,
    required super.expiresIn,
  });

  /// Converts [Map] to [AuthTokenModel].
  ///
  /// Throws `ServerFromJsonException` if the JSON [expiresIn] is not a [num]
  /// or number string. Ex. valid values: `1.0`, `1` or `"1"`.
  ///
  /// {@template model_null_field_error}
  /// Throws `NullFieldServerException` if the JSON has a null field.
  /// {@endtemplate}
  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$AuthTokenModelFromJson(json);
    } on ServerFromJsonException {
      rethrow;
    } catch (e) {
      throw NullFieldServerException();
    }
  }

  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);
}

class ExpireTimeConverter implements JsonConverter<int, Object> {
  const ExpireTimeConverter();

  @override
  int fromJson(Object json) {
    if (json is num) return json.toInt();
    if (json is String) {
      final result = int.tryParse(json);
      return result ?? (throw ServerFromJsonException());
    }
    throw ServerFromJsonException();
  }

  @override
  String toJson(int object) => object.toString();
}
