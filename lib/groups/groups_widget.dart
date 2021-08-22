import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  void _showForm(context) {
    Navigator.of(context).pushNamed('/groups/form/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Группы')),
      ),
      body: _GroupListWidget(),
      floatingActionButton:
          FloatingActionButton(
              onPressed: () =>_showForm(context),
              child: Icon(Icons.add)),
    );
  }
}

class _GroupListWidget extends StatefulWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  _GroupListWidgetState createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<_GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const Divider(height: 1);
        },
        separatorBuilder: (BuildContext context, int index) {
          return _GroupNameWidget(
            indexItem: index,
          );
        },
        itemCount: 100);
  }
}

class _GroupNameWidget extends StatelessWidget {
  final int indexItem;
  const _GroupNameWidget({Key? key, required this.indexItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        actionPane: const SlidableBehindActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Удалить',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => {},
          ),
        ],
        child: ColoredBox(
            color: Colors.white,
            child: ListTile(
              title: Text('Название группы'),
              trailing: Icon(Icons.chevron_right),
              onTap:(){} ,
            )));
  }
}
