import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/providers/team_provider.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';

class SelectTeamsScreen extends ConsumerStatefulWidget {
  const SelectTeamsScreen({super.key});

  @override
  ConsumerState<SelectTeamsScreen> createState() => _SelectTeamsScreenState();
}

class _SelectTeamsScreenState extends ConsumerState<SelectTeamsScreen> {
  final List<Team> _selectedTeams = [];
  bool selected = false;
 

  @override
  Widget build(BuildContext context) {
    final teamState = ref.watch(teamControllerProvider);
    final teamController = ref.read(teamControllerProvider.notifier);
    final tournamentId = ref.watch(selectedTournamentIdProvider);
    
     if (!teamState.loading && teamState.teams.isEmpty && tournamentId != null) {
        teamController.loadFilteredTeams( tournamentId);

    }

   if (teamState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (teamState.error.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text('Error: ${teamState.error}')),
      );
    }

   
    if (teamState.teams.isEmpty) {
      return Scaffold(
        body: const Center(child: Text('No hay equipos disponibles')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Equipos')),
      body: ListView.builder(
        itemCount: teamState.teams.length,
        itemBuilder: (context, index) {
          final team = teamState.teams[index];
          return CheckboxListTile(
            value: selected,
            title: Text(team.name),
            secondary: Image.network(team.shield, width: 40, height: 40),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedTeams.add(team);
                } else {
                  _selectedTeams.remove(team);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final tournamentId = ref.read(selectedTournamentIdProvider);
          if (tournamentId != null && _selectedTeams.isNotEmpty) {
            await ref
                .read(teamControllerProvider.notifier)
                .addTeamsToTournament(tournamentId, _selectedTeams.toList());
            Navigator.pop(context); // volver a TeamsTab
          }
        },
        label: const Text('Agregar'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
