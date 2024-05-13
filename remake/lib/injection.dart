import 'package:get_it/get_it.dart';
import 'package:remake/data/datasource/services.dart';
import 'package:remake/data/repository/tasks_repo_impl.dart';
import 'package:remake/domain/repository/tasks_repository.dart';
import 'package:remake/domain/usecase/add_usecase.dart';
import 'package:remake/domain/usecase/delete_usecase.dart';
import 'package:remake/domain/usecase/get_usecase.dart';
import 'package:remake/domain/usecase/update_usecase.dart';
import 'package:remake/presentation/bloc/export.dart';

final ls = GetIt.instance;

Future<void> injectionInit() async {
  // service
  ls.registerSingleton<DataServices>(
      DataServices()); // mendaftarkan class service kedalam get it

  // repository
  ls.registerSingleton<TaskRepository>(TasksRepositoryImpl(
      ls())); // mendaftarkan class repository kedalam get it

  // usecase

  ls.registerSingleton<AddTaskUsecaseImpl>(AddTaskUsecaseImpl(ls()));
  ls.registerSingleton<UpdateTaskUsecaseImpl>(UpdateTaskUsecaseImpl(ls()));
  ls.registerSingleton<DeleteTaskUsecaseImpl>(DeleteTaskUsecaseImpl(ls()));
  ls.registerSingleton<GetTaskUsecaseImpl>(GetTaskUsecaseImpl(ls()));

  // bloc

  ls.registerFactory<TaskBloc>(() => TaskBloc(ls(), ls(), ls(), ls()));
}
