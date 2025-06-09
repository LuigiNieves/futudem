import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/providers/group_provider.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/providers/tournament_team_provider.dart';

class TournamentOrchestrator {
  final Ref ref;

  TournamentOrchestrator(this.ref);

  Future<void> startTournament() async {
    final tournamentController = ref.read(tournamentControllerProvider.notifier);
    final groupController = ref.read(groupControllerProvider.notifier);
    final tournamentId = ref.read(selectedTournamentIdProvider);


    print( "Starting tournament with ID: $tournamentId");

    await tournamentController.startTournament(tournamentId!);
    await tournamentController.loadTournaments();


    await groupController.createGroups(tournamentId);

    await tournamentController.getTeamsByTournament(tournamentId);
    final teams = ref.read(tournamentControllerProvider).teams;

    await groupController.assignTeamsRandomly(tournamentId, teams);

    ref.read(groupControllerProvider.notifier).fetchTeamsWithGroups (tournamentId);
    await groupController.loadGroups(tournamentId);

    
    await groupController.createMatchesForTournament(tournamentId);

    await groupController.loadMatches(tournamentId);
    

  }


  
}
