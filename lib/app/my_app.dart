import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo-list',
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: mainNavigation.initialRoute,
    );
  }
}
