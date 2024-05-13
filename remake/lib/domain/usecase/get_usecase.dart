import 'package:remake/core/usecase/usecase.dart';
import 'package:remake/data/models/task_models.dart';
import 'package:remake/domain/repository/tasks_repository.dart';

class GetTaskUsecaseImpl
    implements Usecase2<List<TaskModels>, void> {
  final TaskRepository _repository;
  const GetTaskUsecaseImpl(this._repository);

  @override
  Stream<List<TaskModels>> call({void params}) {
    return _repository.getTasks();
  }
}
