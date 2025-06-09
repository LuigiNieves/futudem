import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/providers/group_provider.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';
import 'package:futudem_app/screens/tournament/tabs/groups_tab.dart';
import 'package:futudem_app/screens/tournament/tabs/match_tab.dart';
import 'package:futudem_app/screens/tournament/tabs/teams_tab.dart';

class TournamentDetailScreen
    extends ConsumerStatefulWidget {
  final List<Team> teamsList;
  final Map<String, List<dynamic>> groupList;
  // final Map<String, List<Match>> matchList;
  // final List<Match> finalMatches;
  final String role;

  const TournamentDetailScreen({
    super.key,
    required this.teamsList,
    required this.groupList,
    required this.role,
  });

  @override
  ConsumerState<TournamentDetailScreen> createState() =>
      _TournamentDetailScreenState();
}

class _TournamentDetailScreenState
    extends ConsumerState<TournamentDetailScreen> {
  @override
  void initState() {
    super.initState();

    // final tournament =
    //     ref.read(tournamentControllerProvider).tournament;
    // final tournamentId = tournament?.id;

    final tournamentId = ref.read(
      selectedTournamentIdProvider,
    );

    if (tournamentId != null) {
      // Llamamos al fetch en una microtarea para evitar errores del ciclo de vida
      Future.microtask(() {
        ref
            .read(groupControllerProvider.notifier)
            .fetchTeamsWithGroups(tournamentId);
        ref
            .read(groupControllerProvider.notifier)
            .loadGroups(tournamentId);
        ref
            .read(groupControllerProvider.notifier)
            .loadMatches(tournamentId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupState = ref.watch(groupControllerProvider);
    final tournamentTeamState = ref.watch(
      tournamentControllerProvider,
    );

    final isActive =
        tournamentTeamState.tournament?.isActive ?? false;
    final groups = GroupTeamDto.teamsByGroup(
      groupState.groupTeams,
    );

    final matches = MatchDto.matchesByGroup(
      groupState.matches,
    );

    final List<Tab> tabs = [];
    final List<Widget> tabViews = [];

    if (widget.role == 'admin') {
      tabs.add(const Tab(text: "Equipos"));
      tabViews.add(TeamsTab(equipos: widget.teamsList));
    }

    tabs.add(const Tab(text: "Grupos"));
    tabViews.add(
      GroupsTab(group: groups, isActive: isActive),
    );

    tabs.add(const Tab(text: "Partidos"));
    tabViews.add(
      MatchTab(matchesList: matches, role: widget.role),
    );

    // tabs.add(const Tab(text: "Finales"));
    // tabViews.add(FinalsTab(finalMatches: widget.finalMatches, role: widget.role));

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
