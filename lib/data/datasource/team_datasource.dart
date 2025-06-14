import 'package:futudem_app/models/team.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeamRemoteDatasource {
  final _client = Supabase.instance.client;

  Future<List<Team>> getAllTeams() async {
    try {
      final List<dynamic> data = await _client
          .from('team')
          .select('id, name, shield');
      return data
          .map((item) => Team.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Error fetching teams: $e');
    }
  }

  Future<void> addTeamToTournament(
    int tournamentId,
    int teamId,
    int captainId,
  ) async {
    try {
      final tournamentTeamEntries = {
        'tournament_id': tournamentId,
        'team_id': teamId,
        'captain_id': captainId,
      };

      await _client
          .from('tournament_team')
          .insert(tournamentTeamEntries);
    } catch (e) {
      throw Exception(
        'Error adding teams to tournament: $e',
      );
    }
  }

  Future<Team> getTeamById(int id) async {
    try {
      final data =
          await _client
              .from('team')
              .select()
              .eq('id', id)
              .single();
      return Team.fromJson(data);
    } catch (e) {
      throw Exception('Error fetching team by ID: $e');
    }
  }

  Future<void> createTeam(Team team) async {
    try {
      final existing =
          await _client
              .from('team')
              .select()
              .eq('id', team.id)
              .maybeSingle();
      if (existing != null) {
        return;
      }
      await _client.from('team').insert(team.toMap());
    } catch (e) {
      throw Exception('Error creating team: $e');
    }
  }

  Future<void> updateTeam(Team team) async {
    try {
      await _client
          .from('team')
          .update(team.toMap())
          .eq('id', team.id);
    } catch (e) {
      throw Exception('Error updating team: $e');
    }
  }

  Future<void> deleteTeam(int id) async {
    try {
      await _client.from('team').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting team: $e');
    }
  }

  Future<List<Team>> getTeamsByTournament(
    int tournamentId,
  ) async {
    try {
      final List<dynamic> data = await _client
          .from('team')
          .select('id, name, shield')
          .eq('tournament_id', tournamentId);
      return data
          .map((item) => Team.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception(
        'Error fetching teams by tournament: $e',
      );
    }
  }
}
