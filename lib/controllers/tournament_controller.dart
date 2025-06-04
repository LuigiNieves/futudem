

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/state_tournament.dart';
import 'package:futudem_app/models/repositories/tournament_repository.dart';

class TournamentTeamController extends StateNotifier<StateTournamentTeam> {
  final TournamentTeamRepository _tournamentTeamRepository;

  TournamentTeamController(this._tournamentTeamRepository) : super(StateTournamentTeam.initial());

  Future<void> getTeamsByTournament(int tournamentId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _tournamentTeamRepository.getTeamsByTournament(tournamentId);
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}