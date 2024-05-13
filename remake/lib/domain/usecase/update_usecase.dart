import 'package:remake/core/resource/datastate.dart';
import 'package:remake/core/usecase/usecase.dart';
import 'package:remake/domain/entities/task_entities.dart';
import 'package:remake/domain/repository/tasks_repository.dart';

class UpdateTaskUsecaseImpl implements Usecase<DataState<void>, TaskEntities> {
  final TaskRepository _repository;
  const UpdateTaskUsecaseImpl(this._repository);

  @override
  Future<DataState<void>> call({TaskEntities? params}) {
    return _repository.updateTask(params!);
  }
}
