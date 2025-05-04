import 'package:flutter/material.dart';
import 'package:futudem_app/mock/data.dart';

class FinalesPage extends StatelessWidget {
  const FinalesPage({super.key});

  Widget _buildMatchTile(String homeTeamName, String awayTeamName, {String? homeFlag, String? awayFlag}) {
    return ListTile(
      leading: homeFlag != null
          ? Image.network(homeFlag, width: 30)
          : const Icon(Icons.help_outline, size: 30),
      title: Text('$homeTeamName vs $awayTeamName'),
      trailing: awayFlag != null
          ? Image.network(awayFlag, width: 30)
          : const Icon(Icons.help_outline, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Cuartos de Final',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...mockKnockoutMatches.map((match) => _buildMatchTile(
              match.homeTeam.name,
              match.awayTeam.name,
              homeFlag: match.homeTeam.flagUrl,
              awayFlag: match.awayTeam.flagUrl,
            )),
        const SizedBox(height: 20),
        const Text('Semifinales',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _buildMatchTile('Ganador Cuarto 1', 'Ganador Cuarto 2'),
        _buildMatchTile('Ganador Cuarto 3', 'Ganador Cuarto 4'),
        const SizedBox(height: 20),
        const Text('Final',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _buildMatchTile('Ganador Semifinal 1', 'Ganador Semifinal 2'),
      ],
    );
  }
}
