import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/team/state_team.dart';
import 'package:futudem_app/models/repositories/team_repository.dart';
import 'package:futudem_app/models/team.dart';

class TeamController extends StateNotifier<StateTeam> {
  final TeamRepository _teamRepository;
 

  TeamController(this._teamRepository) : super(StateTeam.initial()){
    loadteams();
  }

  Future<void> loadteams() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.fetchAllTeams();
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> addTeams(int tournamentId, List<Team> teams) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _teamRepository.addTeamsToTournament(tournamentId, teams);
      await fetchAllTeams();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchAllTeams() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.fetchAllTeams();
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  
  Future<void> getTeamsByTournament(int tournamentId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.getTeamsByTournament(tournamentId);
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }


  Future<void> loadFilteredTeams(int tournamentId) async {
  state = state.copyWith(loading: true, error: '');

  try {
    final allTeams = await _teamRepository.fetchAllTeams();
    final selectedTeams = await _teamRepository.getTeamsByTournament(tournamentId);
    print('Selected Teamssss: ${selectedTeams.length}');
    print('All Teamssss: ${allTeams.length}');
    final selectedIds = selectedTeams.map((team) => team.id).toSet();

    final filteredTeams = allTeams
        .where((team) => !selectedIds.contains(team.id))
        .toList();

    state = state.copyWith(loading: false, teams: filteredTeams);
  } catch (e) {
    state = state.copyWith(loading: false, error: e.toString());
  }
}

Future<void> addTeamsToTournament(int tournamentId, List<Team> teams) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _teamRepository.addTeamsToTournament(tournamentId, teams);
    
      await loadFilteredTeams(tournamentId);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  // Define your methods to update the state here
}