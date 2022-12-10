import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:hive/hive.dart';
import 'package:the_24_hour/feature/auth/data/model/auth_token_model.dart';

@immutable
class AuthToken extends Equatable {
  const AuthToken({
    required this.localId,
    required this.email,
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  @HiveField(0)
  final String localId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String idToken;
  @HiveField(3)
  final String refreshToken;
  @ExpireTimeConverter()
  @HiveField(4)
  final int expiresIn;

  @override
  List<Object?> get props => [
        localId,
        email,
        idToken,
        refreshToken,
        expiresIn,
      ];
}
