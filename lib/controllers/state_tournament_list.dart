
import 'package:futudem_app/models/tournament.dart';

class StateTournamentList {
  final bool loading;
  final String error;
  final List<Tournament> data;
  
  StateTournamentList({
    required this.loading,
    required this.error,
    required this.data,
  });

  factory StateTournamentList.initial() {
    return StateTournamentList(
      loading: false,
      error: '',
      data: [],
    );
  }

  StateTournamentList copyWith({
    bool? loading,
    String? error,
    List<Tournament>? data,
  }) {
    return StateTournamentList(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

} 