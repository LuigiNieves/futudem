import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/mock/data.dart' as data;
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';
import 'package:futudem_app/screens/tournament/create_tournament_screen.dart';
import 'package:futudem_app/screens/tournament/tournament_detail_screen.dart';

class TournamentScreen extends ConsumerWidget {
  final String role;

  const TournamentScreen({super.key, required this.role});


  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tournamentcontroller = ref.watch(tournamentControllerProvider);

  

    print('TournamentScreen: ${tournamentcontroller.loading}');

    if (tournamentcontroller.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tournamentcontroller.error.isNotEmpty) {
      return Center(child: Text('Error: ${tournamentcontroller.error}'));
    }

    final tournaments = tournamentcontroller.data;
    
    
    print('objects: $tournaments');

    return Scaffold(
      appBar: AppBar(title: const Text('Torneos')),
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(tournament.name),
              subtitle: Text('Fecha de inicio: ${tournament.startDate}'),
              onTap: () async {
                ref.read(selectedTournamentIdProvider.notifier).state = tournament.id;

                await ref.read(tournamentControllerProvider.notifier).getTeamsByTournament(tournament.id);
                ref.read(tournamentControllerProvider.notifier).selectedTournament(tournament);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TournamentDetailScreen(
                      teamsList: data.mockTeams,
                      groupList: {'A': data.groupA, 'B': data.groupB},
                      
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
// This screen displays a list of tournaments and allows admins to create new tournaments.