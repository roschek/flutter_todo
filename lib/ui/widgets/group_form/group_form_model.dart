import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter/domains/entity/group.dart';

class GroupFormModel {
  var groupName = '';
  void saveGroup(BuildContext context) async{
    if(groupName.isEmpty) return;
    if(!Hive.isAdapterRegistered(1)){
      Hive.registerAdapter(GroupAdapter());
    }
     final box =  await Hive.openBox<Group>('group_box');
     final group = Group(name: groupName);
     box.add(group);
     Navigator.of(context).pop();
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
    return  false;
  }
}