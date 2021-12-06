import 'package:flutter/material.dart';

class PoketDetailInfo {
  final String avatarUrl;
  final Map<String, String> infos;
  final List<String> skills;
  const PoketDetailInfo(
      {required this.avatarUrl, required this.infos, required this.skills});
}

class PoketmonDetails extends StatelessWidget {
  final PoketDetailInfo poketDetailInfo;
  const PoketmonDetails({required this.poketDetailInfo, Key? key})
      : super(key: key);

  Widget _printLabelAndValue(String label, String value) {
    return (Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 42),
            )),
      ],
    ));
  }

  Widget _printSkill(String skillName) {
    return (Row(
      children: [
        const Icon(Icons.check_circle_outline),
        Text(skillName),
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
              backgroundImage: NetworkImage(poketDetailInfo.avatarUrl),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black),
            for (var e in poketDetailInfo.infos.entries)
              _printLabelAndValue(e.key, e.value),
            for (String skillName in poketDetailInfo.skills)
              _printSkill(skillName),
          ],
        ),
      ),
    );
  }
}
