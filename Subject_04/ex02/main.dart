import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class DataType {
  final String timestamp;
  DataType({required this.timestamp});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final newData = {
              'apple': '사과',
              'banana': '바나나',
              'pineapple': '파인애플',
            };
            FirebaseFirestore.instance
                .collection('PROFILE')
                .doc('myData')
                .set(newData);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
