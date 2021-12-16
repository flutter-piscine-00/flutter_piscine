class Photo {
  final Set<String> tags;
  final String previewURL;

  Photo({
    required this.tags,
    required this.previewURL,
  });

  Photo.fromMap(Map<String, dynamic> map)
      : tags = makeSetFromStr(map['tags']),
        previewURL = map['previewURL'];

  static Set<String> makeSetFromStr(String tags) {
    final Set<String> ret = Set();
    final splited = tags.split(', ');
    ret.addAll(splited);
    return ret;
  }
}
