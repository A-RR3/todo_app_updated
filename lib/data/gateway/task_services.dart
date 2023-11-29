import 'package:todo_app_updated/data/datasource/database_services.dart';
import 'package:todo_app_updated/domain/entities/task.dart';
import 'package:todo_app_updated/domain/interfaces/task_interface.dart';
import 'package:todo_app_updated/utils/data_base_config.dart';

//task provider
class TaskServices extends DataBaseServices<Task> implements TasksInterface {
  String get table => AppKeys.taskTable;

  @override
  Future<int> addTask(Task model) async {
    return await create(model);
  }

  @override
  Future<Task> getSingleTask(int id) async {
    return retrieveOne(table, Task.fromMap, id);
  }

  @override
  Future<int> deleteTask(Task task) async {
    return await delete(task);
  }

  @override
  Future<List<Task>> readAll() async {
    return retrieveAll(table, Task.fromMap);
  }

  @override
  Future<int> updateTask(Task task) async {
    return await update(task);
  }
}
