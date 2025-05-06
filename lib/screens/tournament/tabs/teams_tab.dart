import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';

class TeamsTab extends StatelessWidget {
  final List<Team> equipos;

  const TeamsTab({super.key, required this.equipos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: equipos.length,
      itemBuilder: (context, index) {
        final equipo = equipos[index];
        return ListTile(
          title: Row(
            children: [
              Image.network(equipo.flagUrl),
              const SizedBox(width: 10),
              Text(equipo.name),
            ],
          ),
        );
      },
    );
    
  }
}
