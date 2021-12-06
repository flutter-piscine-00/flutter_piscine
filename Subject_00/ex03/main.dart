import 'package:flutter/material.dart';
import 'custom_widget/blur_image.dart';

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
        primarySwatch: Colors.teal,
      ),
      home:
          const MyHomePage(key: ValueKey(1), title: 'Stateless? or Stateful?'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  static const String squidGameTitleSrcPath =
      'https://w.namu.la/s/420422c9668360c3654fb8d4ba4b4921a22a8732d660e08d81cfa5281035aae6573a4f61927aaeecdcf6ee911af6ea5a4aa49bef54be3f63ada78ac5f914e1cfb4b78e644e2190944fb886f2688ffb91';

  static const String squidGamePosterSrcPath =
      'https://maxmovie.cdnsave.com/images/1628644797279L0zPH.jpg';

  const MyHomePage({required Key key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: AppBar(
            backgroundColor: Colors.black,
          )),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(color: Colors.black),
          const BlurImage(key: ValueKey(1), imagePath: squidGamePosterSrcPath),
          Image.network(squidGameTitleSrcPath),
        ],
      ),
    ));
  }
}
