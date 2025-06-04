import 'package:futudem_app/models/team.dart';

abstract class TeamRepository {
  Future<List<Team>> fetchAllTeams();
  Future<Team> getTeamById(int id);
  Future<List<Team>> getTeamsByTournament(int tournamentId);
  Future<void> addTeamsToTournament(int tournamentId, List<Team> teams);
  Future<void> createTeam(Team team);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(int id);
}
