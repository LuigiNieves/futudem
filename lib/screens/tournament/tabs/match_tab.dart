import 'package:flutter/material.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';

class MatchTab extends StatefulWidget {
  final Map<String, List<MatchDto>> matchesList;
  final String role;

  const MatchTab({super.key, required this.matchesList, required this.role});
  

  @override
  State<MatchTab> createState() => _MatchTabState();
}


class _MatchTabState extends State<MatchTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          widget.matchesList.entries.map((entry) {
            return ExpansionTile(
              title: Text(entry.key),
              children:
                  entry.value.map<Widget>((match) {
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
                                    if (widget.role == 'admin')
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 20),
                                        onPressed: () async {
                                          // final updatedMatch =
                                          //     await showDialog<Match>(
                                          //       context: context,
                                          //       builder:
                                          //           (context) => MatchDialog(
                                          //             match: match,
                                          //           ),
                                          //     );
                                          // if (updatedMatch != null) {
                                          //   setState(() {
                                          //     // match.match.homeGoals =
                                          //     //     updatedMatch.homeGoals;
                                          //     // match.match.awayGoals =
                                          //     //     updatedMatch.awayTeamGoals;
                                          //     // match.date = updatedMatch.date;
                                          //   });
                                          // }
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
