import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/db/db_helper.dart';
import 'package:task_app/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;
  Future<int> addTasks({Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    final tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  @override
  void onInit() {
    super.onInit();
    getTasks();
    debugPrint('debugPrintIsHere: getx onint');
  }
}
