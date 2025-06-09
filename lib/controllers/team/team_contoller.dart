import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/team/state_team.dart';
import 'package:futudem_app/models/repositories/team_repository.dart';
import 'package:futudem_app/models/team.dart';

class TeamController extends StateNotifier<StateTeam> {
  final TeamRepository _teamRepository;
 

  TeamController(this._teamRepository) : super(StateTeam.initial()){
    loadTeams();
  }

  Future<void> loadTeams() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.fetchTeamsFromApi();
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> createTeam(Team team) async {
    // state = state.copyWith(loading: true, error: '');
    try {
      await _teamRepository.createTeam(team);
      await getAllTeams();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }



  Future<void> getAllTeams() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.getAllTeams();
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchAllTeamsFromApi() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.fetchTeamsFromApi();
      print( 'Teams fetched from API: $teams');
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }



  
  Future<void> getTeamsByTournament(int tournamentId) async {
    // state = state.copyWith(loading: true, error: '');
    try {
      final teams = await _teamRepository.getTeamByTournament(tournamentId);
      state = state.copyWith(loading: false, teams: teams);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }


  Future<void> loadFilteredTeams(int tournamentId) async {
  state = state.copyWith(loading: true, error: '');

  try {
    final allTeams = await _teamRepository.fetchTeamsFromApi();
    final selectedTeams = await _teamRepository.getTeamByTournament(tournamentId);
    final selectedIds = selectedTeams.map((team) => team.id).toSet();

    final filteredTeams = allTeams
        .where((team) => !selectedIds.contains(team.id))
        .toList();

    state = state.copyWith(loading: false, teams: filteredTeams);
  } catch (e) {
    state = state.copyWith(loading: false, error: e.toString());
  }
}

Future<void> addTeamToTournament(int tournamentId, int teamId, int captainId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      await _teamRepository.addTeamToTournament(tournamentId, teamId, captainId);
      state = state.copyWith(loading: false, error: '');
      // await loadTeams();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  // Define your methods to update the state here
}