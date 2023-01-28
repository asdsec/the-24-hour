// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      done: json['done'] as bool,
      startDate:
          const DateJsonConverter().fromJson(json['start_date'] as Timestamp),
      endDate:
          const DateJsonConverter().fromJson(json['end_date'] as Timestamp),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'done': instance.done,
      'start_date': const DateJsonConverter().toJson(instance.startDate),
      'end_date': const DateJsonConverter().toJson(instance.endDate),
    };
