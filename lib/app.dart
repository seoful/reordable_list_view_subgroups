import 'package:flutter/material.dart';
import 'package:phisicl_test_task/tasks_structure/tasks_list_item_types.dart';
import 'package:phisicl_test_task/tasks_structure/tasks_structure.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final structure = TasksStructure();

  List<TaskListItem>? _listItems;

  @override
  void initState() {
    structure.initialize().then((value) {
      setState(() {
        _listItems = structure.widgets;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Builder(builder: (context) {
          if (_listItems != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    structure.reorder(oldIndex, newIndex);
                    _listItems = structure.widgets;
                  });
                },
                children: _listItems!.map<Widget>((e) {
                  if (e is SetHeaderItem) {
                    return _buildSetHeader(e);
                  }
                  if (e is SetEndItem) {
                    return _buildSetEnd(e);
                  }
                  if (e is TaskItem) {
                    return _buildTaskItem(e);
                  }
                  return Container();
                }).toList(),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  Widget _buildSetHeader(SetHeaderItem setHeaderItem) {
    return IgnorePointer(
      key: Key("Header ${setHeaderItem.order}"),
      child: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(10),
        child: Text(
          "Set #${setHeaderItem.order.toString()}",
        ),
      ),
    );
  }

  Widget _buildSetEnd(SetEndItem setEndItem) {
    return IgnorePointer(
      key: Key("End ${setEndItem.order}"),
      child: const Divider(
        color: Colors.grey,
        thickness: 2,
        height: 20,
      ),
    );
  }

  Widget _buildTaskItem(TaskItem taskItem) {
    return Card(
      key: Key("Task ${taskItem.task.id}"),
      color: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Task #${taskItem.task.id.toString()}",
        ),
      ),
    );
  }
}
