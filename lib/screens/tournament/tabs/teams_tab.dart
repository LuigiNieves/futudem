import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';
import 'package:futudem_app/screens/add_teams_to_tournament.dart';

class TeamsTab extends ConsumerStatefulWidget {
  final List<Team> equipos;

  const TeamsTab({super.key, required this.equipos});

  @override
  ConsumerState<TeamsTab> createState() => _TeamsTabState();
}

class _TeamsTabState extends ConsumerState<TeamsTab> {
  void _startTournament() {
    // TODO: Implement tournament start logic
    // For now, just show a snackbar as a placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Torneo iniciado (placeholder)')),
    );
  }

  void _addTeam() {
    // TODO: Implement add team logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agregar team (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
     final tournamentTeamState = ref.watch(tournamentTeamControllerProvider);
    final teams = tournamentTeamState.teams;
    print('objecccct: teams: $teams');
    if (tournamentTeamState.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (tournamentTeamState.error.isNotEmpty) {
      return Center(child: Text('Error: ${tournamentTeamState.error}'));
    }
    if (tournamentTeamState.teams.isEmpty) {
      return const Center(child: Text('No hay equipos disponibles'));
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: Image.network(
                team.shield,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(team.name),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'agregar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SelectTeamsScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'iniciar',
            onPressed: _startTournament,
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
