import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/mock/data.dart' as data;
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/providers/tournament_list_provider.dart';
import 'package:futudem_app/screens/tournament/create_tournament_screen.dart';
import 'package:futudem_app/screens/tournament/tournament_detail_screen.dart';

class TournamentScreen extends ConsumerWidget {
  final String role;

  const TournamentScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentState = ref.watch(tournamentControllerProvider);

    if (tournamentState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tournamentState.error.isNotEmpty) {
      return Center(child: Text('Error: ${tournamentState.error}'));
    }

    final tournaments = tournamentState.data;
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
              onTap: () {
                ref.read(selectedTournamentIdProvider.notifier).state = tournament.id;

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
