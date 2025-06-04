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
      throw Exception('Error fetching tournament by ID: $e');
    }
  }

  Future<void> createTournament(Tournament tournament) async {
    try {
      await _client.from('tournament').insert(tournament.toMap());
    } catch (e) {
      throw Exception('Error creating tournament: $e');
    }
  }

  Future<void> updateTournament(Tournament tournament) async {
    if (tournament.id == null) {
      throw Exception('Tournament id cannot be null for update.');
    }
    try {
      await _client.from('tournament').update(tournament.toMap()).eq('id', tournament.id!);
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
        .select('team(id, name, logo_url)') // join implícito con la tabla team
        .eq('tournament_id', tournamentId);

    // extraemos los datos de la relación
    return data.map((item) => Team.fromJson(item['team'])).toList();
  } catch (e) {
    throw Exception('Error fetching teams by tournament ID: $e');
  }
}






  

}