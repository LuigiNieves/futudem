import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart' as data;

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.mockTeams.length,
            itemBuilder: (context, index) {
              final team = data.mockTeams[index];
              return ListTile(
                leading: Image.network(team.flagUrl),
                title: Text(team.name),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Lógica para agregar a torneo
                  },
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Lógica de iniciar torneo
          },
          child: Text('Iniciar Torneo'),
        ),
      ],
    );
  }
}
