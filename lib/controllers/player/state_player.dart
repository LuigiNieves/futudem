import 'package:futudem_app/models/player.dart';

class StatePlayer {
  final Player player;
  final List<Player> players;
  final bool loading;
  final String error;

  StatePlayer({
    required this.player,
    required this.players,
    required this.loading,
    required this.error,
  });

  factory StatePlayer.initial() {
    return StatePlayer(
      player: Player(id: 33, name: '', lastName: ''),
      players: [],
      loading: false,
      error: '',
    );
  }

  StatePlayer copyWith({
    Player? player,
    List<Player>? players,
    bool? loading,
    String? error,
  }) {
    return StatePlayer(
      player: player ?? this.player,
      players: players ?? this.players,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
