import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter/domains/entity/group.dart';
import 'package:todo_flutter/domains/entity/task.dart';


class TaskFormModel {
  int groupKey;
  var taskText = '';

  TaskFormModel({ required this.groupKey });

  void saveTask(BuildContext context) async{
    if(taskText.isEmpty) return;
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
    if(!Hive.isAdapterRegistered(2)){
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);
    final groupBox =  await Hive.openBox<Group>('group_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedWidget {
  final  TaskFormModel model;
  const TaskFormWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key,   child: child);

  static TaskFormWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetModelProvider old) {
    return false;
  }
}