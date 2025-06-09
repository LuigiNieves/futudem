import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';
import 'package:futudem_app/models/team.dart';

abstract class GroupRepository {
  Future<List<Group>> fetchAllGroups(int tournamentId);
  
  Future<List<Group>> createGroups(int tournamentId);

  Future<void> assignTeamsToGroups(int tournamentId, int groupId, List<Team> teams);

  Future<List<GroupTeamDto>> fetchTeamsWithGroups(int tournamentId);


    // match

  Future<List<MatchDto>> fetchGroupsWithMatches(int tournamentId);
  Future<void> createMatch(MatchFixture match);
  Future<void> updateMatch(MatchFixture match);
  // Future<List<MatchFixture>> fetchGroupsWithTeams(int tournamentId); 

}