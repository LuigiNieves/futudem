import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart' as data;
import 'package:futudem_app/models/team.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late List<Team> teams;

  @override
  void initState() {
    super.initState();
    teams = List.from(data.mockTeams); 
  }

  void _addTeam() async {
    final result = await showAddTeamDialog(context);
    if (result != null) {
      setState(() {
        teams.add(
          Team(
            name: result['name']!,
            flagUrl: 'https://cdn-icons-png.flaticon.com/512/197/197484.png',
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
    return Scaffold(
      appBar: AppBar(title: const Text('Equipos del Torneo')),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ListTile(
            leading: Image.network(team.flagUrl, width: 40, height: 40),
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
