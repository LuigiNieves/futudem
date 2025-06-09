import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/providers/player_provider.dart';
import 'package:futudem_app/providers/team_provider.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/screens/widgets/player_dialog.dart';

class SelectTeamsScreen extends ConsumerStatefulWidget {
  const SelectTeamsScreen({super.key});

  @override
  ConsumerState<SelectTeamsScreen> createState() =>
      _SelectTeamsScreenState();
}

class _SelectTeamsScreenState
    extends ConsumerState<SelectTeamsScreen> {

  @override
  Widget build(BuildContext context) {
    final teamState = ref.watch(teamControllerProvider);
    final playerState = ref.watch(playerControllerProvider);



    final teamController = ref.read(
      teamControllerProvider.notifier,
    );
    final tournamentId = ref.watch(
      selectedTournamentIdProvider,
    );

    if (!teamState.loading &&
        teamState.teams.isEmpty &&
        tournamentId != null) {
      teamController.fetchAllTeamsFromApi();
    }

    if (teamState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (teamState.error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text('Error: ${teamState.error}'),
        ),
      );
    }

    if (teamState.teams.isEmpty) {
      return Scaffold(
        body: const Center(
          child: Text('No hay equipos disponibles'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Equipos'),
      ),
      body: ListView.builder(
        itemCount: teamState.teams.length,
        itemBuilder: (context, index) {
          final team = teamState.teams[index];
          return ListTile(
            leading: Image.network(
              team.shield,
              width: 40,
              height: 40,
            ),
            title: Text(team.name),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                              final Player? captain = await showDialog<Player>(
                                context: context,
                                builder: (context) {
                                  return PlayerDialog();
                                },
                              );
              
                              if (captain == null) return;
              
                              await ref.read(teamControllerProvider.notifier).createTeam(team);

                              await ref.read(playerControllerProvider.notifier).createPlayer(captain);

                              final createdCaptain =  ref.read(playerControllerProvider).player;

                              final newTeam = teamState.teams.firstWhere((t) => t.name == team.name);

                              await ref.read(teamControllerProvider.notifier).addTeamToTournament(
                                tournamentId!,
                                newTeam.id,
                                createdCaptain.id,
                              );
                              
                            },
            ),
          );
        },
      ),
    
    );
  }
}
