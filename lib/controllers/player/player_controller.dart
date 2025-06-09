

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/player/state_player.dart';
import 'package:futudem_app/models/repositories/player_repository.dart';
import 'package:futudem_app/models/player.dart';

class PlayerController extends StateNotifier<StatePlayer> {
final PlayerRepository _playerRepository;

  PlayerController(this._playerRepository) : super(StatePlayer.initial());

  Future<void> loadPlayers() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final players = await _playerRepository.fetchAllPlayers();
      state = state.copyWith(loading: false, players: players);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchPlayersByCc(String  playerId) async {
    // state = state.copyWith(loading: true, error: '');
    try {
      final player = await _playerRepository.fetchPlayersByCc(playerId);
      state = state.copyWith(loading: false, player: player);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
   
  }

  Future<void> createPlayer(Player player) async {
    // state = state.copyWith(loading: true, error: '');
    try {
       final createdPlayer = await _playerRepository.createPlayer(player);
       state = state.copyWith(loading: false, player: createdPlayer);
      await fetchAllPlayers();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> fetchAllPlayers() async {
    state = state.copyWith(loading: true, error: '');
    try {
      final players = await _playerRepository.fetchAllPlayers();
      state = state.copyWith(loading: false, players: players);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

 


}