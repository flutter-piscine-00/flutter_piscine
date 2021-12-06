import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(key: ValueKey(1),));
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day00_Ex02',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyPage(key: ValueKey(1),),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({required Key key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int count = 0;

  final snackBar = const SnackBar(content: Text('answer to life to universe and everything'));

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: const Text('Stateless? or Stateful?')
    );
  }

  void _addButtonPressedHandler() {
    setState(() {
      count++;
    });
    if (count == 42) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildBody() {
    return (
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$count',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 42)
            ),
            ElevatedButton(
              onPressed: _addButtonPressedHandler, 
              child: const Text('Add')
            ),
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    count = 41;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}
