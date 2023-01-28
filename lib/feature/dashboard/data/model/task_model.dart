import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_24_hour/feature/dashboard/domain/entity/task.dart';
import 'package:the_24_hour/product/error/exception.dart';

part 'task_model.g.dart';

@immutable
@JsonSerializable()
@DateJsonConverter()
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.done,
    required super.startDate,
    required super.endDate,
  });

  // Todo: implement fromFirestore test

  /// Converts [Map?] to [TaskModel].
  ///
  /// {@macro model_null_field_error}
  factory TaskModel.fromJson(Map<String, dynamic>? json) {
    try {
      return _$TaskModelFromJson(json!);
    } catch (e) {
      throw NullFieldServerException();
    }
  }

  /// Converts [TaskModel] to [Map]
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}

class DateJsonConverter implements JsonConverter<DateTime, Timestamp> {
  const DateJsonConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}
