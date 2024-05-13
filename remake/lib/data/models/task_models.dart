import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remake/domain/entities/task_entities.dart';

// membuat fungsi untuk mengconvert enum kedalam string , agar dapat diterima kedalam colecction firebase
Priority _convert(String priority) {
  switch (priority) {
    case "low":
      return Priority.low;
    case "medium":
      return Priority.medium;
    case "high":
      return Priority.high;
    default:
      return Priority.low;
  }
}

class TaskModels extends TaskEntities {
  // membuat class model untuk berinteraksi dengan api
  const TaskModels({
    bool complete = false,
    String id = '',
    required Priority priority,
    required TaskData task,
  }) : super(complete: complete, id: id, priority: priority, task: task);

  factory TaskModels.fromDoc(DocumentSnapshot doc) {
    // membuat metode factory , untuk mengambil data dari document
    final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return TaskModels(
      complete: data?['complete'] ?? false,
      id: doc.id,
      priority: _convert(doc["priority"]),
      task: TaskModelsData.fromMap(data?['task'] ?? {}),
    );
  }
}

class TaskModelsData extends TaskData {
  const TaskModelsData({
    required String title,
    required DateTime time,
  }) : super(
          title: title,
          dateTime: time,
        );

  factory TaskModelsData.fromMap(Map<String, dynamic> map) {
    return TaskModelsData(
        title: map['title'] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] ?? 0));
  }
}
