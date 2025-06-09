
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/player/player_controller.dart';
import 'package:futudem_app/controllers/player/state_player.dart';
import 'package:futudem_app/data/datasource/player_datasource.dart';
import 'package:futudem_app/repositories/player_repository_impl.dart';

final playerControllerProvider = StateNotifierProvider<PlayerController, StatePlayer>(
  (ref) {
    final dataSource = PlayerRemoteDatasource();
    final playerRepository = PlayerRepositoryImpl(dataSource);

    return PlayerController(playerRepository);
  },
);