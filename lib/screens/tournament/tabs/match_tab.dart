import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';
import 'package:futudem_app/providers/group_provider.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/screens/widgets/match_dialog.dart';

class MatchTab extends ConsumerWidget {
  final Map<String, List<MatchDto>> matchesList;
  final String role;

  const MatchTab({super.key, required this.matchesList, required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: matchesList.entries.map((entry) {
        return ExpansionTile(
          title: Text(entry.key),
          children: entry.value.map<Widget>((match) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                match.homeTeam?.name ?? '',
                                textAlign: TextAlign.end,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.network(
                              match.homeTeam.shield,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${match.match.homeGoals ?? '-'} vs ${match.match.awayGoals ?? '-'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.network(
                              match.awayTeam.shield,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                match.awayTeam.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (role == 'admin')
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () async {
                                  final updatedMatchFixture =
                                      await showDialog<MatchFixture>(
                                    context: context,
                                    builder: (context) => MatchDialog(
                                      match: match,
                                    ),
                                  );
                                  // Aquí deberías actualizar el estado global usando un provider
                                  if (updatedMatchFixture != null) {
                                    final tournamentId = ref
                                        .read(selectedTournamentIdProvider);

                                    await ref.read(groupControllerProvider.notifier).updateMatch(updatedMatchFixture);
                                    await ref.read(groupControllerProvider.notifier).fetchMatchesByTournament(tournamentId!);
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    match.match.matchDate != null
                        ? 'Fecha: ${match.match.matchDate!.toString().split(' ')[0]}'
                        : 'Fecha: pendiente',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
