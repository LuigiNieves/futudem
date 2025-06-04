
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/state_tournament.dart';
import 'package:futudem_app/controllers/tournament_controller.dart';
import 'package:futudem_app/data/datasource/tournament_team_datasource.dart';
import 'package:futudem_app/providers/selected_tournament_provider.dart';
import 'package:futudem_app/repositories/tournament_team_repository_impl.dart';

final tournamentTeamControllerProvider = StateNotifierProvider<TournamentTeamController, StateTournamentTeam>(
  (ref) {
    final datasource = TournamentTeamRemoteDatasource();
    final repository = TournamentTeamRepositoryImpl(datasource);

    final tournamentId =ref.watch(selectedTournamentIdProvider);
    final controller = TournamentTeamController(repository);
    controller.getTeamsByTournament(tournamentId!);
    return controller;
  },
);