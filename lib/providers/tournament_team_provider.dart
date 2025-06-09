
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/tournament/state_tournament.dart';
import 'package:futudem_app/controllers/tournament/tournament_controller.dart';
import 'package:futudem_app/data/datasource/tournament_datasource.dart';
import 'package:futudem_app/repositories/tournament_repository_impl.dart';

final tournamentControllerProvider = StateNotifierProvider<TournamentController, StateTournament>(
  (ref) {
    final datasource = TournamentRemoteDatasource();
    final repository = TournamentRepositoryImpl(datasource);

    return TournamentController(repository);
  },
);