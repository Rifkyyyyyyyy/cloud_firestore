import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remake/core/resource/datastate.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/domain/usecase/add_usecase.dart';
import 'package:remake/domain/usecase/delete_usecase.dart';
import 'package:remake/domain/usecase/get_usecase.dart';
import 'package:remake/domain/usecase/update_usecase.dart';
import 'export.dart';

import 'dart:async';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUsecaseImpl _add; // mengambil usecase dari implementasi add
  final UpdateTaskUsecaseImpl
      _update; // mengambil usecase dari implementasi update
  final DeleteTaskUsecaseImpl
      _delete; // mengambil usecase dari implementasi delete
  final GetTaskUsecaseImpl _get; // mengambil usecase dari implemetasi get

  Stream<List<TaskEntities>> get dataStream =>
      _get(); // meng'get data dari hasil stream _get

  Stream<String> get allTask {
    return dataStream.map((event) => event.length
        .toString()); // meng'get panjang dari data hasil data stream
  }

  Stream<String> get filterTime {
    // meng'get data dari datastream dan memfilter jumlah data berdasarkan waktu pada hari ini
    DateTime now = DateTime.now();
    return dataStream.map((event) => event
        .where((element) =>
            element.task.dateTime.year == now.year &&
            element.task.dateTime.month == now.month &&
            element.task.dateTime.day == now.day)
        .length
        .toString());
  }

  TaskBloc(this._add, this._get, this._delete, this._update)
      : super(TaskInitial()) {
    on<AddTasksEvents>(_addTask); // menambahkan event add task
    on<UpdateTasksEvemts>(_updateTask); // menambahkan event update task
    on<DeleteTasksEvents>(_deleteTask); // menambahkan event delete task
    on<GetTasksEvents>(_getTask); // menambahkan event get task
  }

  void _updateTask(
      UpdateTasksEvemts events, Emitter<TaskState> emitter) async {}

  void _deleteTask(
      DeleteTasksEvents events, Emitter<TaskState> emitter) async {}

  void _addTask(AddTasksEvents events, Emitter<TaskState> emitter) async {
    try {
      final result = await _add.call(
          params: events.task); // memanggil fungsi penambahan dari usecase
      if (result is DataSuccess) {
        // mengecek apakah status data bersifat success
        emitter(const TaskOperation(
            msg:
                'data has been add')); // mengirimkan state operasi success jika data berhasil ditambahkan
        add(GetTasksEvents()); // kembali pada event get task
      } else {
        emitter(TaskFailed(err: result.err!));
      }
    } catch (e) {
      emitter(TaskFailed(err: e.toString()));
    }
  }

  void _getTask(GetTasksEvents events, Emitter<TaskState> emitter) async {
    try {
      await for (var data in _get.call()) {
        // mengakses semua data yang berasal dari implementasi get data secara asynchronus
        if (data.isNotEmpty) {
          emitter(TaskSuccess(
              task:
                  data)); 
        } else {
          emitter(const TaskFailed(
              err:
                  "There are no tasks, please add tasks first")); // mengirimkan state failed dengan pesan penambahan tugas
        }
      }
    } catch (e) {
      emitter(TaskFailed(err: 'Terjadi kesalahan: $e'));
    }
  }
}
