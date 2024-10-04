import 'package:flutter/material.dart';
import 'package:task_manager/models/database_helper.dart';
import 'package:task_manager/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> _filteredTasks = [];
  List<Task> get filteredTasks => _filteredTasks;

  //loading tasks from database
  Future<void> loadTasks(String sortingOrder) async {
    _tasks = await _dbHelper.getTasks(sortingOrder);
    _filteredTasks = _tasks;
    notifyListeners();
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      _filteredTasks = _tasks;
    } else {
      _filteredTasks = _tasks.where((task) {
        return task.taskName.toLowerCase().contains(query.toLowerCase()) ||
            task.taskDesc.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addTask(Task task, String sortingOrder) async {
    await _dbHelper.insertTask(task);
    await loadTasks(sortingOrder);
  }

  Future<void> updateTask(Task task, String sortingOrder) async {
    await _dbHelper.updateTask(task);
    print('reached till TP');
    await loadTasks(sortingOrder);
  }

  Future<void> deleteTask(int id, String sortingOrder) async {
    await _dbHelper.deleteTask(id);
    await loadTasks(sortingOrder);
    print('reached');
  }

  Future<void> displayAllTasksOnConsole() async {
    await _dbHelper.printAllTasks();
  }

  Future<void> toggleTaskFromClass(int index, bool value, String sortingOrder ) async{
    await _dbHelper.toggleTask(index,value);
    await loadTasks(sortingOrder);
  }
}
