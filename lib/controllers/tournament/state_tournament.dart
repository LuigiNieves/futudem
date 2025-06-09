
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/tournament.dart';

class StateTournament {
  final bool loading;
  final String error;
  final Tournament? tournament;
  final List<Tournament> data;
  final List<Team> teams;

  StateTournament({
    required this.loading,
    required this.error,
    required this.tournament,
    required this.data,
    required this.teams,
  });

  factory StateTournament.initial() {
    return StateTournament(
      loading: false,
      error: '',
      tournament: null,
      data: [], 
      teams: [],
    );
  }
  StateTournament copyWith({
    bool? loading,
    String? error,
    Tournament? tournament,
    List<Team>? teams,
    List<Tournament>? data,
  }) {
    return StateTournament(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      tournament: tournament ?? this.tournament,
      teams: teams ?? this.teams,
      data: data ?? this.data,
    );
  }

  
}