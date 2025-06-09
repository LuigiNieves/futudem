import 'package:futudem_app/models/player.dart';

abstract class PlayerRepository {
  Future<List<Player>> fetchAllPlayers();
  Future<Player> createPlayer(Player player);
  Future<void> updatePlayer(Player player);
  Future<void> deletePlayer(String playerId);
  Future<Player> fetchPlayersByCc(String cc);
}
