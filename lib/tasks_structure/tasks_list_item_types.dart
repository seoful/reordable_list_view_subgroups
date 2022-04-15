import 'package:phisicl_test_task/model/task_model.dart';

abstract class TaskListItem {
  final int order;

  const TaskListItem(this.order);
}

class TaskItem extends TaskListItem {
  TaskItem(this.task) : super(task.order);

  final TaskModel task;
}

class SetHeaderItem extends TaskListItem {
  SetHeaderItem(order) : super(order);
}

class SetEndItem extends TaskListItem {
  SetEndItem(order) : super(order);
}
