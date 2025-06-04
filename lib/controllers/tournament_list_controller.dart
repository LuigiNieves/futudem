
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/state_tournament_list.dart';
import 'package:futudem_app/models/repositories/tournament_repository.dart';
import 'package:futudem_app/models/tournament.dart';

class TournamentController  extends StateNotifier<StateTournamentList>  {

  final TournamentRepository _repository;

  TournamentController(this._repository) : super(StateTournamentList.initial()) {
    loadTournaments();
  }



  Future<void> loadTournaments() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final tournaments = await _repository.getTournaments();
      state = state.copyWith(loading: false, data: tournaments);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addTournament(Tournament tournament) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _repository.createTournament(tournament);
      await loadTournaments();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
    
  }


  Future<void> updateTournament(int id, String name) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _repository.updateTournament(id, name);
      await loadTournaments();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }


  Future<void> deleteTournament(int id) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _repository.deleteTournament(id);
      await loadTournaments();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }





 

}