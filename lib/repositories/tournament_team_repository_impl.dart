

import 'package:futudem_app/data/datasource/tournament_team_datasource.dart';
import 'package:futudem_app/models/repositories/tournament_repository.dart';
import 'package:futudem_app/models/team.dart';

class TournamentTeamRepositoryImpl implements TournamentTeamRepository{
  final TournamentTeamRemoteDatasource _datasource;

  TournamentTeamRepositoryImpl(this._datasource);

  @override
  Future<List<Team>> getTeamsByTournament(int tournamentId) {
    return _datasource.fetchTeamsByTournament(tournamentId);
  }

  
  
}