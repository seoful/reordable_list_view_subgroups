import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:phisicl_test_task/model/task_model.dart';

class Repository {

  Future<List<TaskModel>> getTasks() async {
    List<dynamic> json = jsonDecode(await rootBundle.loadString("in.json"));
    final tasks = json.map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
    return tasks;
  }

  void sendTasks(List<TaskModel> tasks){
    final json = jsonEncode(tasks);
    print(json);
  }
}
