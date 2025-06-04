
import 'package:futudem_app/data/datasource/team_datasource.dart';
import 'package:futudem_app/models/repositories/team_repository.dart';
import 'package:futudem_app/models/team.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDatasource _datasource;

  TeamRepositoryImpl(this._datasource);

  @override
  Future<List<Team>> fetchAllTeams() async {
    return await _datasource.fetchAllTeams();
  }

  @override
  Future<void> addTeamsToTournament(int tournamentId, List<Team> teams) {
    return _datasource.addTeamsToTournament(tournamentId, teams);
  }

  @override
  Future<Team> getTeamById(int id) {
    return _datasource.getTeamById(id);
  }

  @override
  Future<void> createTeam(Team team) {
    return _datasource.createTeam(team);
  }

  @override
  Future<void> updateTeam(Team team) {
    return _datasource.updateTeam(team);
  }

  @override
  Future<void> deleteTeam(int id) {
    return _datasource.deleteTeam(id);
  }

  @override
  Future<List<Team>> getTeamsByTournament(int tournamentId) {
    return _datasource.getTeamsByTournament(tournamentId);
  }
}
