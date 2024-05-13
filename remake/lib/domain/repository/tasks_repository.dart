import 'package:remake/core/resource/datastate.dart';
import 'package:remake/data/models/task_models.dart';
import 'package:remake/domain/entities/task_entities.dart';

abstract class TaskRepository {
  Future<DataState<void>> addTask(TaskEntities data); // fungsi utama dalam menambahkan tugas
  Future<DataState<void>> deleteTask(String id); // fungsi utama dalam menghapus tugas
  Future<DataState<void>> updateTask(TaskEntities data); // funsgi utama dalam mengupdate tugas
  Stream<List<TaskModels>> getTasks(); // fungsi utama dalam mengapatkan tugas
}
