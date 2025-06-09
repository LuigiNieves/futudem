import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TournamentRemoteDatasource {

  final _client = Supabase.instance.client;


  Future<List<Tournament>> getTournaments() async {
    try {
      final List<dynamic> data = await _client.from('tournament').select();
      return data.map((item) => Tournament.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching tournaments: $e');
    }
  }

  Future<Tournament> getTournamentById(int id) async {
    try {
      final data = await _client.from('tournament').select().eq('id', id).single();
      return Tournament.fromJson(data);
    } catch (e) {
      throw Exception('Error fetching tournament By ID: $e');
    }
  }

  Future<Tournament> createTournament(Tournament tournament) async {
    try {
      final response = await _client.from('tournament').insert(tournament.toJson()).select().single();
      if (response == null) {
        throw Exception('Failed to create tournament');
      }
      print(response);
      return Tournament.fromJson(response);
    } catch (e) {
      throw Exception('Error creating tournament: $e');
    }
  }

  Future<void> updateTournament(Tournament tournament) async {
    if (tournament.id == null) {
      throw Exception('Tournament id cannot be null for update.');
    }
    try {
      await _client.from('tournament').update(tournament.toJson()).eq('id', tournament.id!);
    } catch (e) {
      throw Exception('Error updating tournament: $e');
    }
  }

  Future<void> deleteTournament(int id) async {
    try {
      await _client.from('tournament').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting tournament: $e');
    }
  }


  Future<List<Team>> fetchTeamsByTournament(int tournamentId) async {
    try {
      final List<dynamic> data = await _client
          .from('tournament_team')
          .select('team(id, name, shield)') 
          .eq('tournament_id', tournamentId);
      return data.map((item) => Team.fromJson(item['team'])).toList();
    } catch (e) {
      throw Exception('Error fetching teams by tournament: $e');
    }
  } 

  Future<void> startTournament(int tournamentId) async {
    if (tournamentId == null) {
      throw Exception('Invalid tournament ID: $tournamentId');
    }
    try {
      await _client.from('tournament').update({'active': true}).eq('id', tournamentId);
    } catch (e) {
      throw Exception('Error starting tournament: $e');
    }
  }





  

}