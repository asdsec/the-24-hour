import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

@immutable
class ServerFailure implements Failure {
  const ServerFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}

@immutable
class CacheFailure implements Failure {
  const CacheFailure();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}
