import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_flutter/ui/widgets/task/task_widget_model.dart';

class TaskWidget extends StatefulWidget {
  final int groupKey;
  const TaskWidget({
    Key? key,
    required this.groupKey,
  }) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late final TaskWidgetModel _model;
  @override
  void initState() {
    super.initState();
    _model = TaskWidgetModel(groupKey: widget.groupKey);

  }

  @override
  Widget build(BuildContext context) {
    return TaskWidgetModelProvider(model: _model, child: TaskWidgetBody());
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => model?.showForm(context), child: Icon(Icons.add)),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksCount =
        TaskWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _TaskTextWidget(
            indexItem: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
        itemCount: tasksCount);
  }
}

class _TaskTextWidget extends StatelessWidget {
  final int indexItem;
  const _TaskTextWidget({Key? key, required this.indexItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.read(context)!.model;
    final task = model.tasks[indexItem];
    final icon = task.isDone ? Icons.done : Icons.portrait;
    final style = task.isDone
        ? TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough)
        : null;

    return Slidable(
        actionPane: const SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Удалить',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => model.deleteTask(indexItem),
          ),
        ],
        child: ColoredBox(
            color: Colors.white,
            child: ListTile(
              title: Text(task.text, style: style),
              trailing: Icon(icon),
              onTap: () => model.checkDoneToggle(indexItem),
            )));
  }
}
