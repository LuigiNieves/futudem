import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/providers/group_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';

class GroupsTab extends ConsumerStatefulWidget {
  final Map<String, List<Team>> group;
  final bool isActive;

  const GroupsTab({super.key, required this.group, required this.isActive});

  @override
  ConsumerState<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends ConsumerState<GroupsTab> {

  @override
  Widget build(BuildContext context) {
    final groupController = ref.watch(groupControllerProvider);
  final groupNotifier = ref.watch(groupControllerProvider.notifier);
  final tournamentState = ref.watch(tournamentControllerProvider);
  final tournament = tournamentState.tournament;
  final isActive = tournament?.isActive ?? false;

  // ✅ Lógica segura que se ejecuta una sola vez si hace falta
  if (isActive && groupController.groupTeams.isEmpty) {
    groupNotifier.loadGroups(tournament!.id);
  }
   if (!isActive) {
      return const Center(
        child: Text('El torneo ya ha comenzado'),
      );
    }
    
    final Map<String, List<Team>> groupedTeams = GroupTeamDto.teamsByGroup(groupController.groupTeams);

    return ListView(
      children: groupedTeams.entries.map((entry) {
        final String groupName = entry.key;
        final List<Team> equipos = entry.value;

        return ExpansionTile(
          title: Text(
            "Grupo $groupName",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                4: FlexColumnWidth(),
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Color(0xFF2E2E2E)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Equipo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Pj',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'G',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'E',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'P',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...equipos.map((equipo) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Image.network(
                              equipo.shield,
                              width: 24,
                              height: 16,
                            ),
                            const SizedBox(width: 8),
                            Flexible(child: Text(equipo.name)),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('0'),
                      ), // Pj
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('0'),
                      ), // G
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('0'),
                      ), // E
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('0'),
                      ), // P
                    ],
                  );
                }),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
