import 'package:flutter/material.dart';

class PoketmonDetails extends StatelessWidget {
  final String avatarUrl;
  final Map<String, String> infos;
  const PoketmonDetails(
      {required this.avatarUrl, required this.infos, Key? key})
      : super(key: key);

  Widget printLabelAndValue(String label, String value) {
    return (Column(
      children: [
        Text(label),
        Text(value),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 2.5 * 42,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black),
            for (var e in infos.entries) printLabelAndValue(e.key, e.value),
          ],
        ),
      ),
    );
  }
}
