import 'package:remake/core/resource/datastate.dart';
import 'package:remake/core/usecase/usecase.dart';
import 'package:remake/domain/repository/tasks_repository.dart';

class DeleteTaskUsecaseImpl implements Usecase<DataState<void>, String> {
  final TaskRepository _repository;
  const DeleteTaskUsecaseImpl(this._repository);

  @override
  Future<DataState<void>> call({String? params}) {
    return _repository.deleteTask(params!);
  }
}
