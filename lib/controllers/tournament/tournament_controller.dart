import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/tournament/state_tournament.dart';
import 'package:futudem_app/models/repositories/tournament_repository.dart';
import 'package:futudem_app/models/tournament.dart';

class TournamentController
    extends StateNotifier<StateTournament> {
  final TournamentRepository _tournamentRepository;

  TournamentController(this._tournamentRepository)
    : super(StateTournament.initial()) {
    loadTournaments();
  }

  Future<void> loadTournaments() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final tournaments =
          await _tournamentRepository.getTournaments();
      state = state.copyWith(
        loading: false,
        data: tournaments,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchTournamentById(int tournamentId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final tournament = await _tournamentRepository
          .getTournamentById(tournamentId);
      state = state.copyWith(
        loading: false,
        tournament: tournament,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addTournament(Tournament tournament) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final Tournament newTournament =
          await _tournamentRepository.createTournament(
            tournament,
          );
      state = state.copyWith(
        loading: false,
        data: [...state.data, newTournament],
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> getTeamsByTournament(
    int tournamentId,
  ) async {
    // state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _tournamentRepository
          .getTeamByTournament(tournamentId);
      state = state.copyWith(
        loading: false,
        teams: teams,
        tournament: state.tournament,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> startTournament(int tournamentId) async {

    state = state.copyWith(
      loading: true,
      error: '',
      tournament: state.tournament?.copyWith(isActive: true),
    );


    try {
      final teams = state.teams;

      if (teams.length < 8) {
        throw Exception(
          'Debe haber al menos 8 equipos para iniciar el torneo',
        );
      }
      await _tournamentRepository.startTournament(
        tournamentId,
      );
      state = state.copyWith(
        loading: false,
        error: '',
        tournament: state.tournament,
        teams: teams,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> selectedTournament(
    Tournament tournament,
  ) async {
    state = state.copyWith(
      tournament: tournament,
      loading: false,
      error: '',
    );
  }
}
