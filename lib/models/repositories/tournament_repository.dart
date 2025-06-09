
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';

abstract class TournamentRepository {
  Future<Tournament> createTournament(Tournament tournament);
  Future<void> updateTournament(int id, String name);
  Future<List<Tournament>> getTournaments();
  Future<List<Team>> getTeamByTournament(int tournamentId);
  Future<Tournament> getTournamentById(int id);
  Future<void> startTournament(int tournamentId);
}

// abstract class TournamentTeamRepository  {
//   Future<List<Team>> getTeamsByTournament(int tournamentId);
//   Future<void> startTournament(int tournamentId);
//   Future<Tournament> getTournamentById(int tournamentId);
// }