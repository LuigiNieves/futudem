import 'package:futudem_app/models/team.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TournamentTeamRemoteDatasource {
  
  final _client = Supabase.instance.client;

  Future<List<Team>> fetchTeamsByTournament(int tournamentId) async {
    try {
      final List<dynamic> data = await _client
          .from('tournament_team')
          .select('team(id, name, shield)') // join implicit with team table
          .eq('tournament_id', tournamentId);
      return data.map((item) => Team.fromJson(item['team'])).toList();
    } catch (e) {
      throw Exception('Error fetching teams by tournament: $e');
    }
  } 

  
}