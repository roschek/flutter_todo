import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter/domains/entity/group.dart';
import 'package:todo_flutter/domains/entity/task.dart';
import 'package:todo_flutter/ui/navigation/main_navigation.dart';

class TaskWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  var _tasks = <Task>[];

  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;
  TaskWidgetModel({required this.groupKey}) {
    _setup();
  }
  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks?? <Task>[];
    notifyListeners();
  }
  void _setupListen() async{
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final box = await Hive.openBox<Task>('tasks_box');
   _readTasks();
   box.listenable().addListener(_readTasks);
  }

  void deleteTask(int groupIndex) async{
    await _group?.tasks?.deleteFromHive(groupIndex);
    await _group?.save();
  }
  void checkDoneToggle(int groupIndex) async{
    final task = group?.tasks?[groupIndex];
    final currentState = _group?.tasks?[groupIndex].isDone ?? false;
    task?.isDone = !currentState;
    await task?.save();
    notifyListeners();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('group_box');
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('tasks_box');
    _loadGroup();
    _setupListen();
  }

  void showForm(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.taskForm, arguments: groupKey);
  }
}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;
  const TaskWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TaskWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
  }

  static TaskWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskWidgetModelProvider>()
        ?.widget;
    return widget is TaskWidgetModelProvider ? widget : null;
  }
}
