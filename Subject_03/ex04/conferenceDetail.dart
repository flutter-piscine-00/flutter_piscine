import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/conference_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceDetail extends StatelessWidget {
  final ConferenceInfo conference;

  ConferenceDetail({required this.conference});

  String _getFormattedDate(DateTime fromDate, DateTime toDate) {
    return DateFormat.yMMMMd().format(fromDate) +
        ' - ' +
        DateFormat.yMMMMd().format(toDate);
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            conference.name,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(conference.location),
          Text(_getFormattedDate(conference.start, conference.end)),
          Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: const Text(
                'Go to official website',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => {_launchUrl(conference.link)},
            ),
          )
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launch(url)) throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conferences'),
      ),
      body: _buildBody(),
    );
  }
}
