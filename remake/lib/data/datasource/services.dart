import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remake/data/models/task_models.dart';
import 'package:remake/domain/entities/task_entities.dart';

// di file ini kita implementasikan logika service kita, jadi sederhana nya ,
// file services adalah file yang bertangung jawab sebagai penguhubung antara aplikasi dengan sisi api

class DataServices {
  // membuat collection baru fireabase dengan nama task.
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('task');

  // membuat fungsi penambahan data
  Future<void> addTask(TaskEntities task) async {
    try {
      await _firestore.add(task
          .toMap()); // disini kita hanya mengirimkan metode to map kita yang sudah kita buat pada class entities sebelumnya. ,
      // jadi di firebase kita akan membuat data map baru sesuai struktur map kita.
    } catch (e) {
      throw Exception('Gagal dalam menambahkan tugas : $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _firestore
          .doc(id)
          .delete(); // menghapus data sesuai id yang sesuai pada firebase.
    } catch (e) {
      throw Exception('Gagal dalam menghapus data : $e');
    }
  }

  Future<void> updateTask(TaskEntities updatedTask) async {
    try {
      await _firestore.doc(updatedTask.id).update(updatedTask
          .toMap()); // mencari task berdasarkan id , selanjutnya akan di update sesuai pada map baru
    } catch (e) {
      throw Exception('Gagal dalam mengupdate tugas : $e');
    }
  }

  Stream<List<TaskModels>> getTasks() {
    try {
      return _firestore.snapshots().map((event) => event.docs
          .map((e) => TaskModels.fromDoc(e))
          .toList()); // disini kita mengembalikan nilai list mengunakan konsep stream , jadi data yang dikirim akan masuk secara stream , maksudnya ,
      // data yang baru ditambahkan / dihapus / selebihnya akan di tunggu selama data tersebut masih ada.
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw Exception('Maaf anda tidak punya akses mengambil data');
      } else {
        throw Exception('Maaf terjadi kesalahan, data tidak dapat diakses!');
      }
    }
  }
}
