import 'package:futudem_app/models/team.dart';

abstract class TeamRepository {
  Future<List<Team>> getAllTeams();
  Future<List<Team>> fetchTeamsFromApi();
  Future<Team> getTeamById(int id);
  Future<List<Team>> getTeamByTournament(int tournamentId);
  Future<void> addTeamToTournament(int tournamentId, int teamId, int captainId);
  Future<void> createTeam(Team team);
  Future<void> updateTeam(Team team);
  Future<void> deleteTeam(int id);
}
