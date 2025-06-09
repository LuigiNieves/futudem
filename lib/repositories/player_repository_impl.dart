

import 'package:futudem_app/data/datasource/player_datasource.dart';
import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/models/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDatasource _dataSource;

  PlayerRepositoryImpl(this._dataSource);

  @override
  Future<List<Player>> fetchAllPlayers() async {
    return await _dataSource.fetchAllPlayers();
  }

  @override
  Future<Player> fetchPlayersByCc(String cc) async {
    return await _dataSource.fetchPlayersByCc(cc);
  }

  @override
  Future<Player> createPlayer(Player player) async {
    return await _dataSource.createPlayer(player);
  }

  @override
  Future<void> updatePlayer(Player player) async {
    await _dataSource.updatePlayer(player);
  }

  @override
  Future<void> deletePlayer(String playerId) async {
    await _dataSource.deletePlayer(playerId);
  }

}


