class TournamentTeam {
  final String id;
  final String tournamentId;
  final String teamId;

  TournamentTeam({
    required this.id,
    required this.tournamentId,
    required this.teamId,
  });

  factory TournamentTeam.fromJson(Map<String, dynamic> json) {
    return TournamentTeam(
      id: json['id'],
      tournamentId: json['tournament_id'],
      teamId: json['team_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tournament_id': tournamentId,
      'team_id': teamId,
    };
  }
}