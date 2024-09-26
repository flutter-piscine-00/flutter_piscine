import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/conferenceDetail.dart';
import './model/conference_data_model.dart';
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
        primarySwatch: Colors.grey,
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
  final TextStyle _listTileTitleStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  late List<ConferenceInfo> conferences = [];

  @override
  void initState() {
    super.initState();
    _getConferenceData();
  }

  Future<List<ConferenceInfo>> _fetchData() async {
    Uri url = Uri.parse(
        'https://raw.githubusercontent.com/junsuk5/mock_json/main/conferences.json');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iter = jsonDecode(response.body);
      final List<ConferenceInfo> confs =
          iter.map((toElement) => ConferenceInfo.fromMap(toElement)).toList();
      return confs;
    } else {
      throw Error();
    }
  }

  void _getConferenceData() async {
    final newConf = await _fetchData();
    setState(() => {conferences = newConf});
  }

  AppBar _buildAppBar(String title) {
    return AppBar(
      title: Text(title),
    );
  }

  Widget _buildConfercensListView() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: conferences.length,
        itemBuilder: (context, index) {
          if (conferences.length > index) {
            final conference = conferences[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ConferenceDetail(
                              conference: conference,
                            )));
              },
              title: Text(conference.name, style: _listTileTitleStyle),
              subtitle: Text(conference.location),
            );
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  Widget _buildCenterWatingBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBody() {
    if (conferences.isEmpty) {
      return _buildCenterWatingBar();
    } else {
      return _buildConfercensListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar('Conferences'),
      body: _buildBody(),
    );
  }
}
