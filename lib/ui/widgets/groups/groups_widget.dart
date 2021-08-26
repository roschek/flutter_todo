import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  _GroupsWidgetState createState() =>_GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget>{
  final model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(model: model, child:_GroupWidgetBody());
  }
}
class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Группы')),
      ),
      body: _GroupListWidget(),
      floatingActionButton:
      FloatingActionButton(
          onPressed: () =>GroupsWidgetModelProvider.read(context)?.model.showForm(context),
          child: Icon(Icons.add)),
    );
  }
}
class _GroupListWidget extends StatelessWidget {
   _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _GroupNameWidget(
            indexItem: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);

        },
        itemCount: groupsCount);
  }
}


class _GroupNameWidget extends StatelessWidget {
  final int indexItem;
  const _GroupNameWidget({Key? key, required this.indexItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = GroupsWidgetModelProvider.read(context)!.model.groups[indexItem];

    return Slidable(
        actionPane: const SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Удалить',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => model.deleteGroup(indexItem),
          ),
        ],
        child: ColoredBox(
            color: Colors.white,
            child: ListTile(
              title: Text(group.name),
              trailing: Icon(Icons.chevron_right),
              onTap:()=> model.showTasks(context, indexItem) ,
            )));
  }
}
