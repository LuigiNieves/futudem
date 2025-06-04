import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';

class GroupsTab extends StatelessWidget {
  final Map<String, List<dynamic>> grupos;

  const GroupsTab({super.key, required this.grupos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: grupos.entries.map((entry) {
        final String groupName = entry.key;
        final List<Team> equipos = entry.value.cast<Team>();

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
