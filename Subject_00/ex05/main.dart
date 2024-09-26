import 'package:flutter/material.dart';
import './poketmon_details.dart';

void main() {
  runApp(const MyApp(key: ValueKey(1)));
}

class MyApp extends StatefulWidget {
  const MyApp({required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(
                        'https://esquilo.io/png/thumb/hiZKt04D3Noh5n9-Ash-Ketchum-PNG-Image.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Ash Ketchum',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Ash Ketchum@pocketmaster.com',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.red, Colors.blue],
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text('Pocket Center'),
          ),
          const ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Support'),
          ),
          const ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = const Color(0xFFFEC825);
  Color primaryColorLight = const Color(0xFFFDDF81);
  void primaryColorChange(Color pc, Color pcl) {
    setState(() {
      primaryColor = pc;
      primaryColorLight = pcl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
      ),
      home: MyHomePage(
        key: const ValueKey(1),
        title: 'My Poket',
        primaryColorChange: primaryColorChange,
      ),
    );
  }
}

typedef PrimaryColorChangeType = void Function(Color c1, Color c2);

class MyHomePage extends StatefulWidget {
  final String title;
  final PrimaryColorChangeType primaryColorChange;
  const MyHomePage(
      {required Key key, required this.title, required this.primaryColorChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

const picaDetail = PoketDetailInfo(
    avatarUrl:
        'https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjVfMjMg/MDAxNDg3OTUzMTI3Mzc0._tG2RA_tY9IZcrw10kWz3YfLkhcuSRxm_rUQoLRhsQEg.hndrmcX4b8HI5c_EJB_JfftjG6C79zJXLQ0g6dZy9FQg.GIF.doghter4our/IMG_3900.GIF?type=w800',
    infos: {'Name': 'Picachu', 'Level': 'Lv.4'},
    skills: ['Body Blow', 'Eletric Shocks', 'Electro Ball']);

const caterDetail = PoketDetailInfo(
    avatarUrl:
        'http://file3.instiz.net/data/file3/2018/08/14/d/7/b/d7b25d5d584d77103901068ed3844b9d.gif',
    infos: {'Name': 'Caterpie', 'Level': 'Lv.2'},
    skills: ['Body Blow', 'Struggle', 'BugBite']);

class _MyHomePageState extends State<MyHomePage> {
  PoketDetailInfo poketDetailInfo = picaDetail;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.title));
  }

  Widget _buildBody() {
    return PoketmonDetails(
      poketDetailInfo: poketDetailInfo,
    );
  }

  void _setPocketDetail(PoketDetailInfo pd) {
    setState(() {
      poketDetailInfo = pd;
    });
  }

  void _chagneThemeToYellow() {
    widget.primaryColorChange(const Color(0xFFFEC825), const Color(0xFFFDDF81));
    _setPocketDetail(picaDetail);
  }

  void _chagneThemeToGreen() {
    widget.primaryColorChange(const Color(0xFF64BB68), const Color(0xFF49b04f));
    _setPocketDetail(caterDetail);
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: _chagneThemeToYellow,
            icon: const Icon(Icons.flash_on_sharp),
          ),
          IconButton(
            onPressed: _chagneThemeToGreen,
            icon: const Icon(Icons.grass),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
