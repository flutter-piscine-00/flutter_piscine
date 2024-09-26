import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp(key: ValueKey(1)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'ex01'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.red,
    );
  }

  Widget _getRemains() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.yellow,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
            ),
          )
        ],
      ),
    );
  }

  BorderSide _getTableBorder() {
    return const BorderSide(
      width: 5,
      color: Colors.black,
      style: BorderStyle.solid,
    );
  }

  Widget _getExpandedStarContainer(Alignment align, double size) {
    return Expanded(
      child: Container(
        alignment: align,
        child: Icon(Icons.star, size: size),
      ),
    );
  }

  Stack _getStar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        _getExpandedStarContainer(Alignment.topCenter, 50),
        _getExpandedStarContainer(Alignment.bottomCenter, 50),
        _getExpandedStarContainer(Alignment.centerLeft, 50),
        _getExpandedStarContainer(Alignment.centerRight, 50),
        _getExpandedStarContainer(Alignment.center, 100),
      ],
    );
  }

  Widget _getTable() {
    return Table(
      border: TableBorder(
        horizontalInside: _getTableBorder(),
        verticalInside: _getTableBorder(),
      ),
      children: <TableRow>[
        TableRow(children: <Widget>[
          TableCell(
              child: Container(
                  color: Colors.grey, height: 200, child: _getStar())),
          TableCell(child: Container(height: 100, color: Colors.blue)),
        ]),
        TableRow(children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Container(height: 150, color: Colors.green),
          ),
          TableCell(
            child: Container(
              height: 200,
              padding: const EdgeInsets.only(bottom: 50),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 90,
                    color: Colors.yellowAccent,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _getTable(),
        _getRemains(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    ));
  }
}
