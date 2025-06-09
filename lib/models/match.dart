import 'package:futudem_app/models/team.dart';

class MatchFixture {
  final int? id;
  final int groupId;
  final int homeTeamId;
  final int awayTeamId;
  final DateTime? matchDate;
  final int? homeGoals;
  final int? awayGoals;
  final String journey;

  MatchFixture({
    this.id,
    required this.homeTeamId,
    required this.awayTeamId,
    this.matchDate,
    required this.groupId,
    this.homeGoals,
    this.awayGoals,
    required this.journey,
  });

  MatchFixture copyWith({
    int? id,
    int? groupId,
    int? homeTeam,
    int? awayTeam,
    DateTime? matchDate,
    int? homeGoals,
    int? awayGoals,
    String? journey,
  }) {
    return MatchFixture(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      homeTeamId: homeTeam ?? this.homeTeamId,
      awayTeamId: awayTeam ?? this.awayTeamId,
      matchDate: matchDate ?? this.matchDate,
      homeGoals: homeGoals ?? this.homeGoals,
      awayGoals: awayGoals ?? this.awayGoals,
      journey: journey ?? this.journey,
    );
  }

  factory MatchFixture.fromJson(Map<String, dynamic> json) {
    return MatchFixture(
      id: json['id'],
      groupId: json['group_id'],
      homeTeamId: json['home_team_id'],
      awayTeamId: json['away_team_id'],
      matchDate: json['match_date'] != null
          ? DateTime.parse(json['match_date'])
          : null,
      homeGoals: json['home_score'],
      awayGoals: json['away_score'],
      journey: (json['journey'] as String?) ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'home_team_id': homeTeamId,
      'away_team_id': awayTeamId,
      'match_date': matchDate?.toIso8601String(),
      'home_score': homeGoals,
      'away_score': awayGoals,
      'journey': journey,
    };
  }
}
