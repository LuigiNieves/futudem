import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/mock/data.dart' as data;
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';

class TeamScreen extends ConsumerStatefulWidget {
  const TeamScreen({super.key});

  @override
  ConsumerState<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends ConsumerState<TeamScreen> {
  late List<Team> teams;



  void _addTeam() async {
    final result = await showAddTeamDialog(context);
    if (result != null) {
      setState(() {
        teams.add(
          Team(
            name: result['name']!,
            shield: 'https://cdn-icons-png.flaticon.com/512/197/197484.png',
          ),
        );
      });
    }
  }

  void _startTournament() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Torneo iniciado!')),
    );
    // Lógica real de torneo iría aquí
  }

  @override
  Widget build(BuildContext context) {
    final tournamentTeamState = ref.watch(tournamentTeamControllerProvider);

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
      appBar: AppBar(title: const Text('Equipos del Torneo')),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ListTile(
            leading: Image.network(team.shield, width: 40, height: 40),
            title: Text(team.name),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'agregar',
            onPressed: _addTeam,
            child: const Icon(Icons.add),
          ),
          
        ],
      ),
    );
  }
}

// Diálogo para agregar equipo
Future<Map<String, String>?> showAddTeamDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final captainNameController = TextEditingController();
  final docController = TextEditingController();

  return showDialog<Map<String, String>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Agregar Equipo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre del equipo'),
            ),
            TextField(
              controller: captainNameController,
              decoration: const InputDecoration(labelText: 'Nombre del capitán'),
            ),
            TextField(
              controller: docController,
              decoration: const InputDecoration(labelText: 'Documento del capitán'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  captainNameController.text.isNotEmpty &&
                  docController.text.isNotEmpty) {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'captain_name': captainNameController.text,
                  'document': docController.text,
                });
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      );
    },
  );
}
