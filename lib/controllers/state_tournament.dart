
import 'package:futudem_app/models/team.dart';

class StateTournamentTeam {
  final bool loading;
  final String error;
  final List<Team> teams;

  StateTournamentTeam({
    required this.loading,
    required this.error,
    required this.teams,
  });

  factory StateTournamentTeam.initial() {
    return StateTournamentTeam(
      loading: false,
      error: '',
      teams: [],
    );
  }
  StateTournamentTeam copyWith({
    bool? loading,
    String? error,
    List<Team>? teams,
  }) {
    return StateTournamentTeam(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      teams: teams ?? this.teams,
    );
  }

  
}