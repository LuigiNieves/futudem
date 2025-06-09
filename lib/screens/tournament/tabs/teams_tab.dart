import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/providers/tournament_orchestrator_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';
import 'package:futudem_app/screens/add_teams_to_tournament.dart';

class TeamsTab extends ConsumerStatefulWidget {
  final List<Team> equipos;

  const TeamsTab({super.key, required this.equipos});

  @override
  ConsumerState<TeamsTab> createState() => _TeamsTabState();
}

class _TeamsTabState extends ConsumerState<TeamsTab> {

  void _startTournament() async {


    try {
     await  ref.read(tournamentOrchestratorProvider).startTournament();

      final tournamentId = ref.read(selectedTournamentIdProvider);
      if (tournamentId != null) {
        ref.read(tournamentControllerProvider.notifier).getTeamsByTournament(tournamentId);
      }


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Torneo iniciado!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    


    final tournamentId = ref.read(selectedTournamentIdProvider);

    ref.read(tournamentControllerProvider.notifier).getTeamsByTournament(tournamentId!);
    final tournamentTeamState = ref.watch(tournamentControllerProvider);
    final isActive = tournamentTeamState.tournament?.isActive ?? false;

    final teams = tournamentTeamState.teams;


    // if (tournamentTeamState.loading) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    if (tournamentTeamState.error.isNotEmpty) {
      return Center(child: Text('Error: ${tournamentTeamState.error}'));
    }

    // if (tournamentTeamState.teams.isEmpty) {
    //   return const Center(child: Text('No hay equipos disponibles'));
    // }
    return Scaffold(
      body: (teams.isEmpty)
          ? const Center(child: Text('No hay equipos disponibles'))
          : ListView.builder(
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
      
      floatingActionButton:  (!isActive)
          ? Column(
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
                    ).then((_) {
                      // Al volver, recarga los equipos
                      final tournamentId = ref.watch(selectedTournamentIdProvider);
                      if (tournamentId != null) {
                        ref.read(tournamentControllerProvider.notifier).getTeamsByTournament(tournamentId);
                      }
                    });
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
            )
          : null,
    );
  }
}
