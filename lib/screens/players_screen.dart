import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart';
import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/screens/widgets/player_dialog.dart';

class MyPlayersTab extends StatefulWidget {
  const MyPlayersTab({super.key});

  @override
  State<MyPlayersTab> createState() => _MyPlayersTabState();
}

class _MyPlayersTabState extends State<MyPlayersTab> {
  List<Player> players = playersList;
      
  void _addPlayer(Player player) {
    setState(() {
      players.add(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(player.name),
            subtitle: Text('${player.name} - ${player.id}'),
            trailing: player.name.isNotEmpty
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.hourglass_top, color: Colors.orange),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
          final newPlayer = await showDialog<Player>(
            context: context,
            builder: (BuildContext context) {
              return const PlayerDialog(); 
            },
          );
          if (newPlayer != null) {
            _addPlayer(newPlayer);
          }
        },
        tooltip: 'Agregar jugador',
        child: const Icon(Icons.add),
      ),
    );
  }
}
