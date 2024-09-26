import 'package:flutter/material.dart';
import './poketmon_details.dart';

void main() {
  runApp(const MyApp(key: ValueKey(1)));
}

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: const Color(0xFFFEC825),
          primaryColorLight: const Color(0xFFFDDF81)),
      home: const MyHomePage(key: ValueKey(1), title: 'My Poket'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  static const String avatarUrl =
      'https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjVfMjMg/MDAxNDg3OTUzMTI3Mzc0._tG2RA_tY9IZcrw10kWz3YfLkhcuSRxm_rUQoLRhsQEg.hndrmcX4b8HI5c_EJB_JfftjG6C79zJXLQ0g6dZy9FQg.GIF.doghter4our/IMG_3900.GIF?type=w800';
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title));
  }

  Widget _buildBody() {
    const poketDetailInfo = PoketDetailInfo(
        avatarUrl: avatarUrl,
        infos: {'Name': 'Picachu', 'Level': 'Lv.4'},
        skills: ['Body Blow', 'Eletric Shocks', 'Electro Ball']);

    return const PoketmonDetails(
      poketDetailInfo: poketDetailInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}
