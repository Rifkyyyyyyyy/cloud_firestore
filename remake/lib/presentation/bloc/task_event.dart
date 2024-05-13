import 'package:equatable/equatable.dart';
import 'package:remake/domain/entities/task_entities.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

class GetTasksEvents extends TaskEvent {}

class UpdateTasksEvemts extends TaskEvent {
  final TaskEntities update;

  const UpdateTasksEvemts({required this.update});
}

class DeleteTasksEvents extends TaskEvent {
  final String id;

  const DeleteTasksEvents({required this.id});
}

class AddTasksEvents extends TaskEvent {
  final TaskEntities task;

  const AddTasksEvents({required this.task});
}
