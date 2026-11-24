import 'package:crud_application_task/feature/data/data_sources/task_remote_data_source.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/task_request.dart';
import '../../domain/entities/task_page.dart';

import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<TaskPage> getTasks({
    required int page,
    required int limit,
  }) {
    return remoteDataSource.getTasks(
      page: page,
      limit: limit,
    );
  }

  @override
  Future<Task> getTaskById(String id) {
    return remoteDataSource.getTaskById(id);
  }

  @override
  Future<Task> createtask(TaskRequest request) {
    return remoteDataSource.createtask(request);
  }

  @override
  Future<Task> updateTask(
    String id,
    TaskRequest request,
  ) {
    return remoteDataSource.updateTask(id, request);
  }

  @override
  Future<Task> deleteTask(String id) {
    return remoteDataSource.deleteTask(id);
  }
}
