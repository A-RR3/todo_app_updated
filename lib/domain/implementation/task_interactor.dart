import 'package:todo_app_updated/data/gateway/task_services.dart';
import 'package:todo_app_updated/domain/entities/task.dart';
import 'package:todo_app_updated/domain/interfaces/task_interface.dart';

class TasksInteractor implements TasksInterface {
  final TaskServices _gateway;
  TasksInteractor() : _gateway = TaskServices();

  @override
  Future<int> addTask(Task task) async {
    return await _gateway.addTask(task);
  }

  @override
  Future<int> deleteTask(Task task) async {
    return await _gateway.deleteTask(task);
  }

  @override
  Future<List<Task>> readAll() async {
    return await _gateway.readAll();
  }

  @override
  Future<Task> getSingleTask(int id) async {
    return await _gateway.getSingleTask(id);
  }

  @override
  Future<int> updateTask(Task task) async {
    return await _gateway.update(task);
  }
}
