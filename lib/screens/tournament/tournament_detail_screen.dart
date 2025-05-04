import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';

class TournamentDetailScreen extends StatelessWidget {
  final List<Team> equipos;
  final Map<String, List<dynamic>> grupos;
  final Map<String, List<dynamic>> partidosPorJornada;
  final List<dynamic> finales;
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
  Widget build(BuildContext context) {
    final List<Tab> tabs = [];
    final List<Widget> tabViews = [];

    if (role == 'admin') {
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
      itemCount: equipos.length,
      itemBuilder: (context, index) {
        final equipo = equipos[index];
        return ListTile(
          title: Row(
            children: [
              Image.network(
                equipo.flagUrl,
                // errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
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
          grupos.entries.map((entry) {
            return ExpansionTile(
              title: Text("Grupo ${entry.key}"),
              children:
                  entry.value.map<Widget>((equipo) {
                    return ListTile(
                      leading: Image.network(equipo.flagUrl, width: 30),
                      title: Text(equipo.name),
                    );
                  }).toList(),
            );
          }).toList(),
    );
  }

  Widget _buildPartidos() {
    return ListView(
      children:
          partidosPorJornada.entries.map((entry) {
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
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.network(
                            match.homeTeam.flagUrl,
                            width: 32,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8),
                          const Text("vs"),
                          SizedBox(width: 8),
                          Image.network(
                            match.awayTeam.flagUrl,
                            width: 32,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 8),
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
padding: const EdgeInsets.all(16),
children: [
const Text('Cuartos de Final',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
...finales.map((match) => ListTile(
leading: Image.network(match.homeTeam.flagUrl, width: 30),
title:
Text('${match.homeTeam.name} vs ${match.awayTeam.name}'),
trailing: Image.network(match.awayTeam.flagUrl, width: 30),
)),
const SizedBox(height: 20),
const Text('Semifinales',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
_buildPlaceholderTile('Ganador Cuarto 1', 'Ganador Cuarto 2'),
_buildPlaceholderTile('Ganador Cuarto 3', 'Ganador Cuarto 4'),
const SizedBox(height: 20),
const Text('Final',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
_buildPlaceholderTile('Ganador Semifinal 1', 'Ganador Semifinal 2'),
],
);
}

Widget _buildPlaceholderTile(String homeName, String awayName) {
return ListTile(
leading: const Icon(Icons.help_outline, size: 30),
title: Text('$homeName vs $awayName'),
trailing: const Icon(Icons.help_outline, size: 30),
);
}
}
