import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart' as data;
import 'package:futudem_app/screens/tournament/create_tournament_screen.dart';
import 'package:futudem_app/screens/tournament/tournament_detail_screen.dart';

class TournamentScreen extends StatelessWidget {
  final String role;

  const TournamentScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> torneos = [
      {'nombre': 'Torneo Apertura', 'fecha': '01/05/2025'},
      {'nombre': 'Torneo Clausura', 'fecha': '01/09/2025'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Torneos')),
      body: ListView.builder(
        itemCount: torneos.length,
        itemBuilder: (context, index) {
          final torneo = torneos[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(torneo['nombre']!),
              subtitle: Text('Fecha de inicio: ${torneo['fecha']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TournamentDetailScreen(
                      teamsList: data.mockTeams,
                      groupList: {'A': data.groupA, 'B': data.groupB},
                      matchList: data.jornadasMap,
                      finalMatches: data.mockKnockoutMatches,
                      role: role, 
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: role == 'admin'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateTournamentScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
