import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


enum Priority { low, medium, high }

class TaskEntities extends Equatable {
  final bool complete;
  final Priority priority;
  final String? id;
  final TaskData task;

  const TaskEntities({
    this.complete = false,
    this.id,
    required this.priority,
    required this.task,
  });

  @override
  List<Object?> get props => [complete, id, task];

  Map<String, dynamic> toMap() {
    return {
      'complete': complete,
      'priority': priority.toString().split('.').last,
      'id': id,
      'task': task.toMap(),
    };
  }
}

class TaskData extends Equatable {
  final String title;
  final DateTime dateTime;


  const TaskData(
      {required this.title, required this.dateTime, });

  @override
  List<Object?> get props => [title, dateTime];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  bool get isEmpty => title.isEmpty;
}
