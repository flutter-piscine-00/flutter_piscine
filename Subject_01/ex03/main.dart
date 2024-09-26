import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp(key: ValueKey(1)));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: HomePage(title: 'ex03'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CardList(),
    ));
  }
}

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class CardInfo {
  String title;
  String subTitle;
  bool isLike;
  static const List<String> subtitles = ['done', 'do not yet'];
  CardInfo() {
    this.title = WordPair.random().asPascalCase;
    this.subTitle = subtitles[Random().nextInt(2)];
    this.isLike = false;
  }
  ListTile getListTile(void Function() onTapHandler) {
    return ListTile(
      onTap: onTapHandler,
      title: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      subtitle: Text(subTitle),
      trailing: isLike
          ? Icon(Icons.favorite, color: Colors.red)
          : Icon(Icons.favorite_border, color: null),
    );
  }
}

class _CardListState extends State<CardList> {
  final List<CardInfo> cardInfos = [];

  @override
  void initState() {
    super.initState();
    _getCardInfo(10);
  }

  void _getCardInfo(int cnt) {
    for (int i = 0; i < cnt; i++) {
      cardInfos.add(CardInfo());
    }
  }

  Container getAlignRemoveText(Alignment align) {
    return (Container(
      padding: EdgeInsets.all(16),
      color: Colors.red,
      child: Text('remove', style: TextStyle(color: Colors.white)),
      alignment: align,
    ));
  }

  Widget _cardListBuilder(BuildContext context, int index) {
    if (cardInfos.length <= index) _getCardInfo(10);
    final cardInfo = cardInfos[index];
    final cardClickHandler = () => {
          setState(() => {cardInfo.isLike = !cardInfo.isLike})
        };
    final dismissedHandler = (DismissDirection dir) => {
          setState(() => {cardInfos.remove(cardInfo)})
        };
    return Dismissible(
      key: UniqueKey(),
      background: getAlignRemoveText(Alignment.centerLeft),
      secondaryBackground: getAlignRemoveText(Alignment.centerRight),
      onDismissed: dismissedHandler,
      child: Card(child: cardInfo.getListTile(cardClickHandler)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(itemBuilder: _cardListBuilder));
  }
}
