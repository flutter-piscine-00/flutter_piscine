class API {
  static const String _url =
      'https://pixabay.com/api/?key=24823219-56da28090093340d27bee1632';
  static String getPhotoUrl(String? q) {
    if (q != null) {
      return _url + '&q=$q';
    } else {
      return _url;
    }
  }
}
