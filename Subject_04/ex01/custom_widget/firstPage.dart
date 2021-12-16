import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/api/api.dart';
import 'package:myapp/custom_widget/iconInputForm.dart';
import 'package:myapp/custom_widget/titleAppBar.dart';
import 'package:myapp/model/photo.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Photo> photos = [];
  List<Photo> filteredPhotos = [];
  String? q;
  String? filter;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getNewPhoto();
    _getNewFilteredPhoto();
  }

  Future<List<Photo>> _fetchData() async {
    Uri url = Uri.parse(API.getPhotoUrl(q));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final bodyObject = jsonDecode(response.body);
      Iterable iter = bodyObject['hits'];
      final List<Photo> photos = iter.map((ele) => Photo.fromMap(ele)).toList();
      return photos;
    } else {
      throw Error();
    }
  }

  void _getNewPhoto() async {
    setState(() {
      isLoading = true;
      photos = [];
      filteredPhotos = [];
    });
    final newPhotos = await _fetchData();
    setState(() {
      photos = newPhotos;
      filteredPhotos = _getNewFilteredPhoto();
      isLoading = false;
    });
  }

  List<Photo> _getNewFilteredPhoto() {
    if (filter != null) {
      return photos.where((ele) => ele.tags.contains(filter)).toList();
    } else {
      return photos;
    }
  }

  Widget _buildGrid() {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return Expanded(
      child: GridView.builder(
        itemCount: filteredPhotos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (ctx, idx) {
          if (filteredPhotos.length > idx) {
            final photo = filteredPhotos[idx];
            final tagsStr = photo.tags.toString();
            final label = tagsStr.substring(1, tagsStr.length - 1);
            return Column(
              children: [
                Expanded(
                    child: Image.network(photo.previewURL, fit: BoxFit.fill)),
                Text(label, textAlign: TextAlign.center),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void searchSaveHandler(String? value) {
    setState(() => {q = value});
    _getNewPhoto();
  }

  void filterChangedHandler(String? value) {
    setState(() {
      filter = value;
      filteredPhotos = _getNewFilteredPhoto();
    });
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          IconInput(
            prefixIconData: Icons.crop_original_outlined,
            subFixIconData: Icons.search,
            inputSaveHandler: searchSaveHandler,
            inputValue: q,
            hintText: 'Search cat, tree ... etc',
          ),
          const SizedBox(height: 8),
          IconInput(
            prefixIconData: Icons.filter,
            hintText: 'Filter : ',
            inputEditingCompletetHandler: filterChangedHandler,
            inputValue: filter,
          ),
          const SizedBox(height: 8),
          _buildGrid(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        titleText: 'Pixabay Search',
      ),
      body: _buildBody(),
    );
  }
}
