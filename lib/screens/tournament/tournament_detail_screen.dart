import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/match.dart';

class TournamentDetailScreen extends StatefulWidget {
  final List<Team> equipos;
  final Map<String, List<dynamic>> grupos;
  final Map<String, List<dynamic>> partidosPorJornada;
  final List<Match> finales;
  final String role;

  const TournamentDetailScreen({
    super.key,
    required this.equipos,
    required this.grupos,
    required this.partidosPorJornada,
    required this.finales,
    required this.role,
  });

  @override
  State<TournamentDetailScreen> createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  Team? semi1Home;
  Team? semi1Away;
  Team? semi2Home;
  Team? semi2Away;
  Team? finalHome;
  Team? finalAway;

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [];
    final List<Widget> tabViews = [];

    if (widget.role == 'admin') {
      tabs.add(const Tab(text: "Equipos"));
      tabViews.add(_buildEquipos());
    }

    tabs.add(const Tab(text: "Grupos"));
    tabViews.add(_buildGrupos());

    tabs.add(const Tab(text: "Partidos"));
    tabViews.add(_buildPartidos());

    tabs.add(const Tab(text: "Finales"));
    tabViews.add(_buildFinales());

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detalles del Torneo"),
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(children: tabViews),
      ),
    );
  }

  Widget _buildEquipos() {
    return ListView.builder(
      itemCount: widget.equipos.length,
      itemBuilder: (context, index) {
        final equipo = widget.equipos[index];
        return ListTile(
          title: Row(
            children: [
              Image.network(equipo.flagUrl),
              const SizedBox(width: 10),
              Text(equipo.name),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGrupos() {
    return ListView(
      children:
          widget.grupos.entries.map((entry) {
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
                      decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
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
                                  equipo.flagUrl,
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

  Widget _buildPartidos() {
    return ListView(
      children:
          widget.partidosPorJornada.entries.map((entry) {
            return ExpansionTile(
              title: Text(entry.key),
              children:
                  entry.value.map<Widget>((match) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              match.homeTeam.name,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.network(
                            match.homeTeam.flagUrl,
                            width: 32,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          const Text("vs"),
                          const SizedBox(width: 8),
                          Image.network(
                            match.awayTeam.flagUrl,
                            width: 32,
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
                        ],
                      ),
                    );
                  }).toList(),
            );
          }).toList(),
    );
  }

  Widget _buildFinales() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        const Text(
          'Cuartos de Final',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...widget.finales.map(
          (match) => ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(match.homeTeam.name, textAlign: TextAlign.end),
                ),
                const SizedBox(width: 8),
                Image.network(
                  match.homeTeam.flagUrl,
                  width: 32,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                const Text("vs"),
                const SizedBox(width: 8),
                Image.network(
                  match.awayTeam.flagUrl,
                  width: 32,
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
              ],
            ),
          ),
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

  Widget _buildSemifinalTile(int semiNumber, Team? home, Team? away) {
  return ListTile(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nombre del equipo local (tap para seleccionar)
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

        // Bandera del equipo local
        home != null
            ? Image.network(home.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
            : const SizedBox(width: 32, height: 20),

        const SizedBox(width: 8),
        const Text("vs"),
        const SizedBox(width: 8),

        // Bandera del equipo visitante
        away != null
            ? Image.network(away.flagUrl, width: 32, height: 20, fit: BoxFit.cover)
            : const SizedBox(width: 32, height: 20),

        const SizedBox(width: 8),

        // Nombre del equipo visitante (tap para seleccionar)
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
              child:
                  finalHome != null
                      ? Text(
                        finalHome!.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      )
                      : Text('Seleccionar', textAlign: TextAlign.end),
            ),
            ),
            const SizedBox(width: 8),
            Image.network(
              finalHome!.flagUrl,
              width: 32,
              height: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
            const Text("vs"),
            const SizedBox(width: 8),
            Image.network(
              finalAway!.flagUrl,
              width: 32,
              height: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8),
             Expanded(
            child: GestureDetector(
              onTap: () => _selectFinalTeam(isHome: true),
              child:
                  finalAway != null
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
      // No permitir selección si no es administrador
      return null;
    }

    List<Team> availableTeams = [];

    for (var match in widget.finales) {
      availableTeams.add(match.homeTeam);
      availableTeams.add(match.awayTeam);
    }
    return await showDialog<Team>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecciona un equipo'),
          children:
              availableTeams.map((team) {
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
          children:
              semifinalWinners.map((team) {
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
