import 'dart:convert';

import 'package:flutter/material.dart';
import './model/todo_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late List<TodoModel> todos = [];

  AppBar _buildAppBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }

  Widget _getExpandedRowButton() {
    return Row(children: [
      Expanded(
        child: ElevatedButton(
          child: Text('Fetch Data'),
          onPressed: fetchDataClickHandler,
        ),
      ),
    ]);
  }

  void fetchDataClickHandler() async {
    TodoModel todo = await _fetchData();
    setState(() => {todos.add(todo)});
  }

  Future<TodoModel> _fetchData() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return TodoModel.fromMap(map);
    } else {
      throw Error();
    }
  }

  Widget _getLeftAlignText(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text),
    );
  }

  Widget _getList() {
    return ListView.builder(
      reverse: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        if (todos.length > index) {
          final todo = todos[index];
          return Card(
            child: Column(
              children: [
                _getLeftAlignText('title : ${todo.title}'),
                _getLeftAlignText('userId : ${todo.userId}'),
                _getLeftAlignText('id : ${todo.id}'),
                _getLeftAlignText('completed : ${todo.completed}'),
              ],
            ),
          );
        } else
          return Container();
      },
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _getList(),
          ),
          _getExpandedRowButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar('Json2Dart'),
      body: _buildBody(),
    );
  }
}
