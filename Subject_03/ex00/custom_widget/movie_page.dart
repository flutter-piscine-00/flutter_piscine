import 'package:flutter/material.dart';
import 'package:myapp/data/movie_data.dart';

class MoviePage extends StatelessWidget {
  List<Widget> _getGridItems() {
    final List<Widget> result = [];
    for (int i = 0; i < movieData.length; i++) {
      final imageUrl = movieData[i]['posterPath']!;
      final sub = imageUrl.substring(1, imageUrl.length - 1);
      final Widget wdg = Container(
        height: 200,
        padding: EdgeInsets.all(2),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            sub,
            fit: BoxFit.fill,
          ),
        ),
      );
      result.add(wdg);
    }
    return result;
  }

  Widget _buildBody() {
    return GridView.count(
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      children: _getGridItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Poster',
          style: TextStyle(fontFamily: 'Fruktur'),
        ),
      ),
      body: _buildBody(),
    );
  }
}
