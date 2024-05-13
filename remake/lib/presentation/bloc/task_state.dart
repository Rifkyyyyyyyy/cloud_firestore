import 'package:equatable/equatable.dart';
import 'package:remake/domain/entities/task_entities.dart';

abstract class TaskState 
   extends Equatable {
  final List<TaskEntities>? task;
  final String? msg;
  final String? err;

  const TaskState({this.task, this.msg, this.err});
  
  @override
  List<Object?> get props => [task, msg, err];
}

class TaskInitial
    extends TaskState {} // membuat inisial state

class TaskLoading
    extends TaskState {} // membuat state untuk menunggu pengoperasian

class TaskSuccess 
    extends TaskState {  // membuat state untuk operasi pengambilan data

// / membuat variabel untuk penampung daftar tugas
  const TaskSuccess({required final List<TaskEntities> task})
      : super(task: task);
}

class TaskOperation
    extends TaskState {  // membuat state operasi sukses

// membuat variabel penampilan pesan
  const TaskOperation({required final String msg}) : super(msg: msg);
}

class TaskFailed
    extends TaskState { // membuat state untuk operasi jika status bersifat error

  // membuat variabel pesan untuk menampilkan pesan error
  const TaskFailed({required final String err}) : super(err: err);
}
