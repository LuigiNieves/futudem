

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/state_tournament_list.dart';
import 'package:futudem_app/controllers/tournament_list_controller.dart';
import 'package:futudem_app/data/datasource/tournament_datasource.dart';
import 'package:futudem_app/repositories/tournament_repository_impl.dart';

final tournamentControllerProvider = StateNotifierProvider<TournamentController, StateTournamentList>(
  (ref) {
    final datasource = TournamentRemoteDatasource();
    final repository = TournamentRepositoryImpl(datasource);
    return TournamentController(repository);
  },
);