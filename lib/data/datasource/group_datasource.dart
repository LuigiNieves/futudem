import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/relations/group_team.dart';
import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';
import 'package:futudem_app/models/team.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GroupRemoteDatasource {
  final _client = Supabase.instance.client;

  // Example method to fetch groups
  Future<List<Group>> fetchGroups(int tournamentId) async {
    try {
      final List<dynamic> data = await _client
          .from('groups')
          .select('id, name, tournament_id')
          .eq('tournament_id', tournamentId);
      return data
          .map((item) => Group.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching groups: $e');
    }
  }

  Future<List<Group>> createGroups(int tournamentId) async {
    try {
      final List<String> groupData = ['grupoA', 'grupoB'];

      for (String groupName in groupData) {
        await _client.from('groups').insert({
          'name': groupName,
          'tournament_id': tournamentId,
        });
      }

      final response = await _client
          .from('groups')
          .select()
          .eq('tournament_id', tournamentId);

      return (response as List)
          .map((json) => Group.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error creating groups: $e');
    }
  }

  Future<void> assignTeamsToGroups(
    int tournamentId,
    int groupId,
    List<Team> teams,
  ) async {
    try {
      final List<Map<String, dynamic>> assignments =
          teams.map((team) {
            return GroupTeam(
              groupId: groupId,
              teamId: team.id,
            ).toJson();
          }).toList();

      await _client.from('group_team').insert(assignments);
    } catch (e) {
      throw Exception(
        'Error assigning teams to groups: $e',
      );
    }
  }

  Future<List<GroupTeamDto>> fetchTeamsWithGroups(
    int tournamentId,
  ) async {
    try {
      final response = await _client
          .from('group_team')
          .select(
            'team_id, group_id, team(name, shield), groups(name, tournament_id)',
          );

      final filter =
          response
              .where(
                (item) =>
                    item['groups']['tournament_id'] ==
                    tournamentId,
              )
              .toList();

      print('Response Supabase: $response');

      return (filter as List<dynamic>)
          .map(
            (e) => GroupTeamDto.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception(
        'Error fetching teams with groups: $e',
      );
    }
  }

  // match

  
 Future<List<MatchDto>> fetchMatchesByTournament(
  int tournamentId,
) async {
  try {
    final List<dynamic> data = await _client
        .from('match')
        .select('''
          id,
          match_date,
          home_score,
          away_score,
          group:group_id(id, name, tournament_id),
          home_team:home_team_id(id, name, shield),
          away_team:away_team_id(id, name, shield)
        ''');

    print('Información de partidos: $data');

    // Filtrar por tournamentId en Dart
    final filtered = data.where((item) =>
      item['group'] != null &&
      item['group']['tournament_id'] == tournamentId
    ).toList();

    return filtered
        .map((item) => MatchDto.fromJson(item))
        .toList();
  } catch (e) {
    throw Exception(
      'Error fetching matches by tournament: $e',
    );
  }
}

  // Crear partido
  Future<void> createMatch(MatchFixture match) async {
    try {
      await _client.from('match').insert(match.toJson());
    } catch (e) {
      throw Exception('Error creating match: $e');
    }
  }

  // Actualizar partido
  Future<void> updateMatch(MatchFixture match) async {
    if (match.id == null) {
      throw Exception(
        'Match id cannot be null for update.',
      );
    }
    try {
      await _client
          .from('match')
          .update(match.toJson())
          .eq('id', match.id!);
    } catch (e) {
      throw Exception('Error updating match: $e');
    }
  }

  // Eliminar partido
}
