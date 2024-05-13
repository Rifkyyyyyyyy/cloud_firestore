import 'dart:async';
import 'package:remake/core/resource/datastate.dart';
import 'package:remake/data/datasource/services.dart';
import 'package:remake/data/models/task_models.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/domain/repository/tasks_repository.dart';

  // pada class ini kita akan mengaplikasikan / meneruskan logika" yang berasal dari data sources
class TasksRepositoryImpl implements TaskRepository {
  // mewarisakan class abstract dari class task repository
  final DataServices _services;

  const TasksRepositoryImpl(this._services);


  @override
  Future<DataState<void>> addTask(TaskEntities data) async {
    try {
      await _services.addTask(data); // memangill fungsi penambahan data
      return const DataSuccess(
          null); // mengembalikan data success dengan nilai null , dikarenakan kita tidak mengembalikan tipe data apa"/void
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> deleteTask(String id) async {
    try {
      await _services.deleteTask(id);
      return const DataSuccess(
          null); // mengembalikan data success dengan nilai null , dikarenakan kita tidak mengembalikan tipe data apa"/void
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<void>> updateTask(TaskEntities data) async {
    try {
      await _services.updateTask(data);
      return const DataSuccess(
          null); // mengembalikan data success dengan nilai null , dikarenakan kita tidak mengembalikan tipe data apa"/void
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Stream<List<TaskModels>> getTasks() {
    try {
      final tasksStream = _services.getTasks();
      return tasksStream.map((tasks) => tasks)
        ..handleError((err) {
          throw Exception('Error: $err');
        }).timeout(const Duration(seconds: 10),
            onTimeout: (sink) => Exception('error : $sink'));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
