import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_24_hour/feature/dashboard/data/model/task_model.dart';
import 'package:the_24_hour/product/enum/firestore_paths.dart';
import 'package:the_24_hour/product/error/exception.dart';

abstract class TaskRemoteDataSource {
  Future<Iterable<TaskModel>> getTasksByDay(int dayId);
  Future<TaskModel> getTasksById();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  const TaskRemoteDataSourceImpl(this.firestore);

  final FirebaseFirestore firestore;

  @override
  Future<Iterable<TaskModel>> getTasksByDay(int dayId) async {
    try {
      // Note: needs user provider for userId

      final querySnapshot = await firestore
          .collection(FirestorePaths.users.name)
          .doc('GmFqfBWsA3XjY81priIwdbM43bs2')
          .collection(FirestorePaths.tasks.name)
          .get();

      final docs = querySnapshot.docs;
      return docs.map((qds) => TaskModel.fromJson(qds.data()));
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<TaskModel> getTasksById() {
    // TODO(sametdmr): implement getTasksById function
    throw UnimplementedError();
  }
}
