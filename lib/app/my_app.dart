import 'package:flutter/material.dart';
import 'package:todo_flutter/group_form/group_form_widget.dart';
import 'package:todo_flutter/groups/groups_widget.dart';
import 'package:todo_flutter/task/task_widget_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo-list',
      routes: {
        '/groups/':  (context) => const GroupsWidget(),
        '/groups/task/': (context) => const TaskWidget(),
        '/groups/form/': (context) => const GroupFormWidget()},
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      initialRoute: '/groups/',
    );
  }
}
