import 'package:crud_application_task/feature/domain/entities/task.dart';
import 'package:crud_application_task/feature/domain/entities/task_page.dart';
import 'package:crud_application_task/feature/domain/entities/task_request.dart';

abstract class TaskRepository {
  Future<TaskPage> getTasks({
    required int page,
    required int limit,
  });
  
  Future<Task> getTaskById(String id);

  Future<Task> createtask(TaskRequest request);

  Future<Task> updateTask(
    String id,
    TaskRequest request,
  );

  Future<Task> deleteTask(String id);
}