import 'package:futudem_app/data/datasource/group_datasource.dart';
import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';
import 'package:futudem_app/models/repositories/group_repository.dart';
import 'package:futudem_app/models/team.dart';

class GroupRepositoryImpl implements GroupRepository {


  final GroupRemoteDatasource _datasource;

  GroupRepositoryImpl(this._datasource);

  @override
  Future<List<Group>> fetchAllGroups(int tournamentId) {
    return _datasource.fetchGroups(tournamentId);
  }

  @override
  Future<List<Group>> createGroups(int tournamentId) {
    return _datasource.createGroups(tournamentId);
  }

  @override
  Future<void> assignTeamsToGroups(int tournamentId, int groupId, List<Team> teams) {
    return _datasource.assignTeamsToGroups(tournamentId, groupId, teams);
  }

  @override
  Future<List<GroupTeamDto>> fetchTeamsWithGroups(int tournamentId) {
    return _datasource.fetchTeamsWithGroups(tournamentId);
  }

  //match

  @override
  Future<List<MatchDto>> fetchGroupsWithMatches(int tournamentId) async {
    return await _datasource.fetchMatchesByTournament(tournamentId);
  }

  @override
  Future<void> createMatch(MatchFixture match) async{
     await _datasource.createMatch(match);
  }

  @override
  Future<void> updateMatch(MatchFixture match) async {
    await _datasource.updateMatch(match);
  }
}
