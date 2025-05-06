import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/screens/widgets/match_dialog.dart';

class FinalsTab extends StatefulWidget {
  final List<Match> finalMatches;
  final String role;

  const FinalsTab({super.key, required this.finalMatches, required this.role});

  @override
  State<FinalsTab> createState() => _FinalsTabState();
}

class _FinalsTabState extends State<FinalsTab> {
  Team? semi1Home;
  Team? semi1Away;
  Team? semi2Home;
  Team? semi2Away;
  Team? finalHome;
  Team? finalAway;


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const Text(
          'Cuartos de Final',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...widget.finalMatches.map(
          (match) => _buildMatchTile(match),
        ),
        const SizedBox(height: 20),
        const Text(
          'Semifinales',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildSemifinalTile(1, semi1Home, semi1Away),
        _buildSemifinalTile(2, semi2Home, semi2Away),
        const SizedBox(height: 20),
        const Text(
          'Final',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildFinalTile(),
      ],
    );
  }

  Widget _buildMatchTile(Match match) {
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(match.homeTeam.name, textAlign: TextAlign.end),
        ),
        const SizedBox(width: 8),
        Image.network(match.homeTeam.flagUrl, width: 32, height: 20, fit: BoxFit.cover),
        const SizedBox(width: 8),
        const Text("vs"),
        const SizedBox(width: 8),
        Image.network(match.awayTeam.flagUrl, width: 32, height: 20, fit: BoxFit.cover),
        const SizedBox(width: 8),
        Expanded(
          child: Text(match.awayTeam.name, overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(width: 8),
        if (widget.role == 'admin') // Solo admin puede editar
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await showDialog<Match>(
                context: context,
                builder: (_) => MatchDialog(match: match),
              );
              if (updated != null) {
                setState(() {
                  final index = widget.finalMatches.indexOf(match);
                  if (index != -1) {
                    widget.finalMatches[index] = updated;
                  }
                });
              }
            },
          ),
      ],
    ),
    subtitle: Center(
      child: Text(
        match.date != null
            ? 'Fecha: ${match.date!.toString().split(" ")[0]}  |  ${match.homeGoals ?? '-'} - ${match.awayGoals ?? '-'}'
            : 'Sin fecha | ${match.homeGoals ?? '-'} vs ${match.awayGoals ?? '-'}',
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}


  Widget _buildSemifinalTile(int semiNumber, Team? home, Team? away) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final selected = await _selectTeam();
                if (selected != null) {
                  setState(() {
                    if (semiNumber == 1) semi1Home = selected;
                    if (semiNumber == 2) semi2Home = selected;
                  });
                }
              },
              child: Text(
                home?.name ?? 'Seleccionar',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          const SizedBox(width: 8),
          home != null
              ? Image.network(home.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
              : const Icon(Icons.help_outline, size: 30),
          const SizedBox(width: 8),
          const Text("vs"),
          const SizedBox(width: 8),
          away != null
              ? Image.network(away.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
              : const Icon(Icons.help_outline, size: 30),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final selected = await _selectTeam();
                if (selected != null) {
                  setState(() {
                    if (semiNumber == 1) semi1Away = selected;
                    if (semiNumber == 2) semi2Away = selected;
                  });
                }
              },
              child: Text(
                away?.name ?? 'Seleccionar',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalTile() {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectFinalTeam(isHome: true),
              child: finalHome != null
                  ? Text(
                      finalHome!.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    )
                  : Text('Seleccionar', textAlign: TextAlign.end),
            ),
          ),
          const SizedBox(width: 8),
          finalHome != null
              ? Image.network(finalHome!.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
              : const SizedBox(width: 32, height: 20),
          const SizedBox(width: 8),
          const Text("vs"),
          const SizedBox(width: 8),
          finalAway != null
              ? Image.network(finalAway!.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
              : const SizedBox(width: 32, height: 20),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectFinalTeam(isHome: false),
              child: finalAway != null
                  ? Text(
                      finalAway!.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    )
                  : Text('Seleccionar', textAlign: TextAlign.start),
            ),
          ),
        ],
      ),
    );
  }

  Future<Team?> _selectTeam() async {
    if (widget.role != 'admin') {
      return null;
    }

    List<Team> availableTeams = [];
    for (var match in widget.finalMatches) {
      availableTeams.add(match.homeTeam);
      availableTeams.add(match.awayTeam);
    }
    return await showDialog<Team>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecciona un equipo'),
          children: availableTeams.map((team) {
            return SimpleDialogOption(
              child: Text(team.name),
              onPressed: () => Navigator.pop(context, team),
            );
          }).toList(),
        );
      },
    );
  }

  void _selectFinalTeam({required bool isHome}) async {
    List<Team> semifinalWinners = [];
    if (semi1Home != null) semifinalWinners.add(semi1Home!);
    if (semi1Away != null) semifinalWinners.add(semi1Away!);
    if (semi2Home != null) semifinalWinners.add(semi2Home!);
    if (semi2Away != null) semifinalWinners.add(semi2Away!);

    if (semifinalWinners.isEmpty) return;

    final Team? selected = await showDialog<Team>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecciona un finalista'),
          children: semifinalWinners.map((team) {
            return SimpleDialogOption(
              child: Text(team.name),
              onPressed: () => Navigator.pop(context, team),
            );
          }).toList(),
        );
      },
    );

    if (selected != null) {
      setState(() {
        if (isHome) {
          finalHome = selected;
        } else {
          finalAway = selected;
        }
      });
    }
  }
}