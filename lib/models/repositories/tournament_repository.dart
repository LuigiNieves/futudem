
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';

abstract class TournamentRepository {
  Future<void> createTournament(Tournament tournament);
  Future<void> updateTournament(int id, String name);
  Future<void> deleteTournament(int id);
  Future<List<Tournament>> getTournaments();
  Future<List<Team>> getTeamByTournament(int tournamentId);
  Future<Tournament> getTournamentById(int id);
}

abstract class TournamentTeamRepository  {
  Future<List<Team>> getTeamsByTournament(int tournamentId);
}