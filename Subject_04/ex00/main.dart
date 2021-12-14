import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:myapp/custom_widget/footer.dart';
import 'package:myapp/models/post.dart';
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
      color: Flutter95.background,
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _setData();
  }

  Future<List<Post>> _fetchData() async {
    Uri url = Uri.parse(Post.getAllUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable iter = jsonDecode(response.body);
      final List<Post> confs =
          iter.map((toElement) => Post.fromMap(toElement)).toList();
      return confs;
    } else {
      throw Error();
    }
  }

  void _setData() async {
    final newPosts = await _fetchData();
    setState(() => {posts = newPosts});
  }

  Widget _imageContainer() {
    return Row(
      children: [
        Container(
          height: 45,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://w.namu.la/s/38ba652856fb56d1d5a883834c3a38738b182255fc003dab113905cdab77e539d1143b1de4c78bad826e1eb5d8828f39514dca3829f277d1d90427777f7fa66eaa7b08c520cb7658e60fbf06b4997ca88f7e0a1bd91229da803e66cdc1dff315'),
                fit: BoxFit.fill),
          ),
        )
      ],
    );
  }

  Widget _marginText95(String text, EdgeInsets margin) {
    return Container(
      margin: margin,
      child: _text95(text),
    );
  }

  Widget _text95(String text) {
    return Text(text,
        overflow: TextOverflow.ellipsis, style: Flutter95.textStyle);
  }

  Widget _firstPageAppBar() {
    return Elevation95(
      type: Elevation95Type.down,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageContainer(),
            SizedBox(height: 8),
            Elevation95(
              type: Elevation95Type.up,
              child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _text95('1.안내/가입'),
                    _text95('2.전자우편'),
                    _text95('3.게시판'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          // horizontal: 8.0,
          // vertical: 8.0,
          ),
      child: Elevation95(
        type: Elevation95Type.down,
        child: SizedBox(
          height: 250,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: posts.length,
            itemBuilder: (ctx, idx) {
              if (posts.length > idx) {
                final post = posts[idx];
                String text = '${post.id} : ${post.title}';
                return Elevation95(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _text95(text),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListHeader() {
    return Container(
      height: 50,
      child: Elevation95(
        type: Elevation95Type.up,
        child: Row(
          children: [
            _marginText95('번호', EdgeInsets.only(left: 8)),
            _marginText95('제목', EdgeInsets.only(left: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (posts.isEmpty) {
      return CircularProgressIndicator();
    }
    return Column(
      children: [
        _firstPageAppBar(),
        _buildListHeader(),
        _buildListView(),
        Footer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold95(
      title: '나우누리에 오신 것을 환영합니다.',
      body: _buildBody(),
      toolbar: Toolbar95(
        actions: [
          Item95(
            label: 'File',
            onTap: (context) {},
          ),
          Item95(label: 'Edit'),
          Item95(label: 'Save'),
        ],
      ),
    );
  }
}
