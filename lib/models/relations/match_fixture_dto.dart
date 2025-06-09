// match_dto.dart
import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/team.dart';

class MatchDto {
  final MatchFixture match;
  final Team homeTeam;
  final Team awayTeam;
  final Group group;

  MatchDto({
    required this.match,
    required this.homeTeam,
    required this.awayTeam,
    required this.group,
  });

  factory MatchDto.fromJson(Map<String, dynamic> json) {
    final matchJson = Map<String, dynamic>.from(json);

    matchJson['id'] = json['id'] as int?;
    matchJson['group_id'] = json['group']?['id'] as int? ?? 0;
    matchJson['home_team_id'] = json['home_team']?['id'] as int? ?? 0;
    matchJson['away_team_id'] = json['away_team']?['id'] as int? ?? 0;

    return MatchDto(
      match: MatchFixture.fromJson(matchJson),
      homeTeam: json['home_team'] != null
          ? Team.fromJson(json['home_team'])
          : Team(id: 0, name: '', shield: ''),
      awayTeam: json['away_team'] != null
          ? Team.fromJson(json['away_team'])
          : Team(id: 0, name: '', shield: ''),
      group: json['group'] != null
          ? Group.fromJson(json['group'])
          : Group(id: 0, name: '', tournamentId: 0),
    );
  }

  static Map<String, List<MatchDto>> matchesByGroup(List<MatchDto> dtos) {
    final Map<String, List<MatchDto>> grouped = {};

    for (final dto in dtos) {
      final groupName = dto.group.name;

      if (!grouped.containsKey(groupName)) {
        grouped[groupName] = [];
      }

      grouped[groupName]!.add(dto);
    }

    return grouped;
  }
}
