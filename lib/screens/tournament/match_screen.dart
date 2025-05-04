import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  final Map<String, List<dynamic>> jornadasMap;

  const MatchScreen({super.key, required this.jornadasMap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: jornadasMap.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value.map((match) {
            return ListTile(
              leading: Image.network(match.homeTeam.flagUrl),
              title: Text('${match.homeTeam.name} vs ${match.awayTeam.name}'),
              trailing: Image.network(match.awayTeam.flagUrl),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
