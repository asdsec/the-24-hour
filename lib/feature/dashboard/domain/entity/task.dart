import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

@immutable
class Task extends Equatable {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.done,
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String title;
  final String description;
  final bool done;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        done,
        startDate,
        endDate,
      ];
}
