import 'package:flutter/material.dart';

class GroupFormModel {
  var groupName = '';
  void saveGroup(BuildContext context){
    print(groupName);
  }
}

class GroupFormModelProvider extends InheritedWidget {
  final GroupFormModel model;
   const GroupFormModelProvider({
    Key? key,
     required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static GroupFormModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormModelProvider>();
  }

  static GroupFormModelProvider? read(BuildContext context){
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormModelProvider>()?.widget;
    return widget is GroupFormModelProvider ? widget :null;
  }
  @override
  bool updateShouldNotify(GroupFormModelProvider old) {
    return  true;
  }
}