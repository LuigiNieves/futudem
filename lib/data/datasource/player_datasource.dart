
import 'package:futudem_app/models/player.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class  PlayerRemoteDatasource {

  final _client = Supabase.instance.client;

  Future<List<Player>> fetchAllPlayers() async {
    try {
      final List<dynamic> data = await _client
          .from('player')
          .select('id, cc, name,last_name');
      return data.map((item) => Player.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching players: $e');
    }
  }

  Future<Player> fetchPlayersByCc(String cc) async {
    try {
      final List<dynamic> data = await _client
          .from('player')
          .select('id, cc, name,last_name')
          .eq('id', cc);
      return data.map((item) => Player.fromJson(item)).first;
    } catch (e) {
      throw Exception('Error fetching players by CC: $e');
    }
  }

  Future<Player> createPlayer(Player player) async {
    try {
      final response = await _client.from('player').insert(player.toMap()).select().single();
      return Player.fromJson(response);
    } catch (e) {
      throw Exception('Error creating player: $e');
    }
  }

  Future<void> updatePlayer(Player player) async {
    try {
      await _client.from('player').update(player.toMap()).eq('id', player.id);
    } catch (e) {
      throw Exception('Error updating player: $e');
    }
  }

  Future<void> deletePlayer(String playerId) async {
    try {
      await _client.from('player').delete().eq('id', playerId);
    } catch (e) {
      throw Exception('Error deleting player: $e');
    }
  }

  

}