import 'package:todo_app_updated/domain/entities/task.dart';

abstract interface class TasksInterface {
  Future<int> addTask(Task task);
  Future<int> updateTask(Task task);
  Future<Task> getSingleTask(int id);
  Future<int> deleteTask(Task task);
  Future<List<Task>> readAll();
}
