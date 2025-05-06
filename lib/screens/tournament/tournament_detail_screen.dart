import 'package:flutter/material.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/screens/tournament/tabs/finals_tab.dart';
import 'package:futudem_app/screens/tournament/tabs/groups_tab.dart';
import 'package:futudem_app/screens/tournament/tabs/match_tab.dart';
import 'package:futudem_app/screens/tournament/tabs/teams_tab.dart';


class TournamentDetailScreen extends StatefulWidget {
  final List<Team> teamsList;
  final Map<String, List<dynamic>> groupList;
  final Map<String, List<Match>> matchList;
  final List<Match> finalMatches;
  final String role;

  const TournamentDetailScreen({
    super.key,
    required this.teamsList,
    required this.groupList,
    required this.matchList,
    required this.finalMatches,
    required this.role,
  });

  @override
  State<TournamentDetailScreen> createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [];
    final List<Widget> tabViews = [];

    if (widget.role == 'admin') {
      tabs.add(const Tab(text: "Equipos"));
      tabViews.add(TeamsTab(equipos: widget.teamsList));
    }

    tabs.add(const Tab(text: "Grupos"));
    tabViews.add(GroupsTab(grupos: widget.groupList));

    tabs.add(const Tab(text: "Partidos"));
    tabViews.add(MatchTab(matchesList: widget.matchList, role: widget.role));

    tabs.add(const Tab(text: "Finales"));
    tabViews.add(FinalsTab(finalMatches: widget.finalMatches, role: widget.role));

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

  
}
