import 'package:futudem_app/models/team.dart';

class StateTeam {
  final List<Team> teams;
  final bool loading;
  final String error;

  StateTeam({
    required this.teams,
    required this.loading,
    required this.error,
  });

  factory StateTeam.initial() {
    return StateTeam(
      teams: [],
      loading: false,
      error: '',
    );
  }

  StateTeam copyWith({
    List<Team>? teams,
    bool? loading,
    String? error,
  }) {
    return StateTeam(
      teams: teams ?? this.teams,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
  