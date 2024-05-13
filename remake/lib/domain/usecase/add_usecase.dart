import 'package:remake/core/resource/datastate.dart';
import 'package:remake/core/usecase/usecase.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/domain/repository/tasks_repository.dart';

class AddTaskUsecaseImpl implements Usecase<DataState<void>, TaskEntities> {
  final TaskRepository _repository;
  const AddTaskUsecaseImpl(this._repository);

  @override
  Future<DataState<void>> call({TaskEntities? params}) {
    if (params == null || params.task.isEmpty) {
      throw Exception('Tolong isi field yang masih kosong !');
    }
    return _repository.addTask(params);
  }
}
