import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class User extends Equatable {
  const User({
    required this.localId,
    required this.email,
    required this.emailVerified,
    required this.displayName,
    required this.photoUrl,
    required this.passwordUpdatedAt,
    required this.validSince,
    required this.disabled,
    required this.lastLoginAt,
    required this.createdAt,
    required this.customAuth,
  });

  final String localId;
  final String email;
  final bool emailVerified;
  final String displayName;
  final String photoUrl;
  final double passwordUpdatedAt;
  final String validSince;
  final bool disabled;
  final String lastLoginAt;
  final String createdAt;
  final bool customAuth;

  @override
  List<Object?> get props => [
        localId,
        email,
        emailVerified,
        displayName,
        photoUrl,
        passwordUpdatedAt,
        validSince,
        disabled,
        lastLoginAt,
        createdAt,
        customAuth,
      ];
}
