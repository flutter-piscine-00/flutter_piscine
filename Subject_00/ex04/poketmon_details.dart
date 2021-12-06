import 'package:flutter/material.dart';

class PoketmonDetails extends StatelessWidget {
  final String avatarUrl;
  final Map<String, String> Infos;
  const PoketmonDetails(
      {required this.avatarUrl, required this.Infos, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 2.5 * 42,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black),
            Align(alignment: Alignment.topLeft, child: Text('Name')),
          ],
        ),
      ),
    );
  }
}
