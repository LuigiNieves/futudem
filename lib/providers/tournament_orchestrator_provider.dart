import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/tournament_orchestrator.dart';

final tournamentOrchestratorProvider = Provider<TournamentOrchestrator>((ref) {
  return TournamentOrchestrator(ref);
});
