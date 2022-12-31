import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Task extends Equatable {
  const Task({
    required this.id,
    this.scheduleId,
    required this.name,
    this.description,
    required this.startTime,
    required this.length,
    required this.done,
  });

  final String id;
  final String? scheduleId;
  final String name;
  final String? description;
  final DateTime startTime;
  final DateTime length;
  final bool done;

  // TODO(sametdmr): add endTime getter function
  // TODO(sametdmr): add postpone function

  @override
  List<Object?> get props => [
        name,
        description,
        startTime,
        length,
        done,
      ];
}
