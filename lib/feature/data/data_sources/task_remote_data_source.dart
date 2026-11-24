import 'package:crud_application_task/core/constants/api_constants.dart';
import 'package:crud_application_task/core/errors/api_exception.dart';
import 'package:crud_application_task/feature/data/models/task_model.dart';
import 'package:crud_application_task/feature/domain/entities/task_page.dart';
import 'package:crud_application_task/feature/domain/entities/task_request.dart';
import 'package:dio/dio.dart';

class TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSource(this.dio);

  //get All Task
  Future<TaskPage> getTasks({required int page, required int limit}) async {
    try {
      final response = await dio.get(
        ApiConstants.tasks,
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = response.data;
      final List<dynamic> taskList = data['data'];
      final meta = data['meta'];

      return TaskPage(
        tasks:
            taskList
                .map(
                  (json) => TaskModel.fromJson(Map<String, dynamic>.from(json)),
                )
                .toList(),
        page: meta['page'],
        limit: meta['limit'],
        total: meta['total'],
        totalPage: meta['totalPage'],
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  //get Task by ID
  Future<TaskModel> getTaskById(String id) async {
    try {
      final response = await dio.get('${ApiConstants.tasks}/$id');
      final data = response.data['data'];
      return TaskModel.fromJson(Map<String, dynamic>.from(data));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  //Create Task
  Future<TaskModel> createtask(TaskRequest request) async {
    try {
      final response = await dio.post(
        ApiConstants.tasks,
        data: {
          'title': request.title,
          'description': request.description,
          'status': request.status,
        },
      );
      final data = response.data['data'];
      return TaskModel.fromJson(Map<String, dynamic>.from(data));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  //Update Task
  Future<TaskModel> updateTask(String id, TaskRequest request) async {
    try {
      final response = await dio.patch(
        '${ApiConstants.tasks}/$id',
        data: {
          'title': request.title,
          'description': request.description,
          'status': request.status,
        },
      );
      final data = response.data['data'];
      return TaskModel.fromJson(Map<String, dynamic>.from(data));
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  //Delete Task
  Future<TaskModel> deleteTask(String id)async{
    try{
      final response = await dio.delete(
        '${ApiConstants.tasks}/$id',
      );
      final data = response.data['data'];

      return TaskModel.fromJson(Map<String,dynamic>.from(data));
    }on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
