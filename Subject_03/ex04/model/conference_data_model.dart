class ConferenceInfo {
  final String name;
  final String link;
  final DateTime start;
  final DateTime end;
  final String location;
  final bool? cocoaOnly;

  ConferenceInfo(
      {required this.name,
      required this.link,
      required this.start,
      required this.end,
      required this.location,
      required this.cocoaOnly});

  ConferenceInfo.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        link = map['link'],
        start = DateTime.parse(map['start']),
        end = DateTime.parse(map['end']),
        location = map['location'],
        cocoaOnly = map['cocoaOnly'];
}
