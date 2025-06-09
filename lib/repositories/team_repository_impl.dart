
import 'package:futudem_app/data/datasource/team_datasource.dart';
import 'package:futudem_app/data/datasource/team_datasource_api.dart';
import 'package:futudem_app/models/repositories/team_repository.dart';
import 'package:futudem_app/models/team.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDatasource _datasource;
  final TeamDatasourceApi _apiDatasource;

  TeamRepositoryImpl(this._datasource, this._apiDatasource);

  @override
  Future<List<Team>> getAllTeams() async {
    return await _datasource.getAllTeams();
  }

  Future<List<Team>> fetchTeamsFromApi() async {
    return await _apiDatasource.fetchTeams();
  }

  @override
  Future<void> addTeamToTournament(int tournamentId, int teamId, int captainId) {
    return _datasource.addTeamToTournament(tournamentId, teamId, captainId);
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
  Future<List<Team>> getTeamByTournament(int tournamentId) {
    return _datasource.getTeamsByTournament(tournamentId);
  }
}
