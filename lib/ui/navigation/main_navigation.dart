import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/widgets/group_form/group_form_widget.dart';
import 'package:todo_flutter/ui/widgets/groups/groups_widget.dart';
import 'package:todo_flutter/ui/widgets/task/task_widget.dart';
import 'package:todo_flutter/ui/widgets/task_form/task_form_widget.dart';

abstract class MainNavigationRouteNames {
  static const groups = 'groups/';
  static const groupForm = 'groups/form/';
  static const tasks = '/groups/tasks/';
  static const taskForm = '/groups/tasks/form/';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupForm: (context) => const GroupFormWidget()
  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.tasks:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TaskWidget(groupKey: groupKey);
          },
        );
      case MainNavigationRouteNames.taskForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TaskFormWidget(groupKey: groupKey);
          },
        );
      default:
        const widget = Text('Navigation Error!!!!');
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
    }
  }
}
