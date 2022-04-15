import 'dart:async';

import 'package:phisicl_test_task/model/task_model.dart';
import 'package:phisicl_test_task/repository.dart';
import 'package:phisicl_test_task/tasks_structure/tasks_list_item_types.dart';

class TasksStructure {
  final _repository = Repository();

  late List<TaskModel> tasks;

  late List<TaskListItem> _widgets;

  List<TaskListItem> get widgets => List.from(_widgets);

  Future<void> initialize() async {
    tasks = await _repository.getTasks();
    _createItems();
  }

  void _createItems() {
    _widgets = [];
    int currentOrder = 0;
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      if (task.order != currentOrder) {
        if (currentOrder != 0) {
          _widgets.add(SetEndItem(currentOrder));
        }
        currentOrder++;

        _widgets.add(SetHeaderItem(currentOrder));
        _widgets.add(TaskItem(task));
      } else {
        _widgets.add(TaskItem(task));
      }
    }
    _widgets.add(SetEndItem(currentOrder));
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _widgets.removeAt(oldIndex);
    _widgets.insert(newIndex, item);

    int currentOrder = 1;
    String currentPrefix = "a";

    for (int i = 0; i < _widgets.length; i++) {
      final item = _widgets[i];
      if (item is SetHeaderItem) {
        if (i - 1 >= 0 && _widgets[i - 1] is TaskItem) {
          currentOrder++;
        }
      }
      if (item is SetEndItem) {
        if(_widgets[i-1] is! SetHeaderItem) {
          currentPrefix = "a";
          currentOrder++;
        }
      }
      if (item is TaskItem) {
        item.task.order = currentOrder;
        if (currentPrefix == "a") {
          if (i+1 < _widgets.length && _widgets[i + 1] is TaskItem) {
            item.task.orderPrefix = "a";
            currentPrefix = _getNextChar(currentPrefix);
          } else {
            item.task.orderPrefix = "";
          }
        } else {
          item.task.orderPrefix = currentPrefix;
          currentPrefix = _getNextChar(currentPrefix);
        }
      }
    }
    tasks.sort();
    _repository.sendTasks(tasks);
    _createItems();
  }



  String _getNextChar(String char) {
    return String.fromCharCode(char.codeUnitAt(0) + 1);
  }
}
