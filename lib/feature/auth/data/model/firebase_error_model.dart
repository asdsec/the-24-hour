import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';
import 'package:the_24_hour/feature/auth/data/model/firebase_errors.dart';
import 'package:the_24_hour/product/error/exception.dart';

part 'firebase_error_model.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class FirebaseErrorModel extends Equatable {
  const FirebaseErrorModel({
    this.error,
  });

  /// Throws `ServerFromJsonException` if any error occurs
  factory FirebaseErrorModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$FirebaseErrorModelFromJson(json);
    } catch (e) {
      throw ServerFromJsonException();
    }
  }

  final Error? error;

  Map<String, dynamic> toJson() => _$FirebaseErrorModelToJson(this);

  /// Throws `LoginException` if error is LoginError
  void throwLoginException() {
    if (error?.message?.isLoginError() ?? false) {
      throw LoginException(error!.message!.message);
    }
  }

  @override
  List<Object?> get props => [error];
}

@immutable
@JsonSerializable()
class Error extends Equatable {
  const Error({
    this.code,
    this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    try {
      return _$ErrorFromJson(json);
    } catch (e) {
      throw ServerFromJsonException();
    }
  }

  final int? code;
  final FirebaseErrors? message;

  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  @override
  List<Object?> get props => [code, message];
}
