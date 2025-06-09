import 'package:futudem_app/data/datasource/tournament_datasource.dart';
import 'package:futudem_app/models/repositories/tournament_repository.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';

class TournamentRepositoryImpl implements TournamentRepository {
  final TournamentRemoteDatasource _datasource;

  TournamentRepositoryImpl(this._datasource);

  @override
  Future<Tournament> createTournament(Tournament tournament) async {
    return await _datasource.createTournament(tournament);
  }

  @override
  Future<void> updateTournament(int id, String name) async {
    final tournament = Tournament(
      id: id,
      name: name,
      startDate: '2023-10-01', // Example date, replace with actual logic
      isActive: true, // Example status, replace with actual logic
    );
    await _datasource.updateTournament(tournament);
  }


  @override
  Future<List<Tournament>> getTournaments() async {
    return await _datasource.getTournaments();
  }

 
  @override
  Future<List<Team>> getTeamByTournament(int tournamentId) async {
    return await _datasource.fetchTeamsByTournament(tournamentId);
  }

  @override
  Future<Tournament> getTournamentById(int id) async {
    return await _datasource.getTournamentById(id);
  }

  @override
  Future<void> startTournament(int tournamentId) async {
    print('luiginieves with ID: $tournamentId');
    await _datasource.startTournament(tournamentId);
  }

}