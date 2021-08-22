import 'package:flutter/material.dart';

import 'group_form_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  _GroupFormWidgetState createState() => _GroupFormWidgetState();
}
  class _GroupFormWidgetState extends State<GroupFormWidget>{
    final _model = GroupFormModel();
    @override
    Widget build(BuildContext context){
      return GroupFormModelProvider(model: _model, child:_GroupFormWidgetBody());
    }
  }


class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Новая группа')
      ),
      body: Center(
        child: Container(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: _GroupNameWidget()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.done),
        onPressed: () => GroupFormModelProvider.read(context)?.model.saveGroup(context),
      ),
    );
  }
}


class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        helperText: 'Название группы',
      ),
      onChanged: (value)=> model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}
