
import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/team.dart';

class GroupTeamDto {
  final Team team;
  final Group group;

  GroupTeamDto({required this.team, required this.group});

  factory GroupTeamDto.fromJson(Map<String, dynamic> json) {
    final teamJson = json['team'];
    final groupJson = json['groups'];

    if (teamJson == null || groupJson == null) {
      throw Exception(
        'Datos incompletos en GroupTeamDto: $json',
      );
    }

    teamJson['id'] = json['team_id'];
    groupJson['id'] = json['group_id'];

    return GroupTeamDto(
      team: Team.fromJson(teamJson),
      group: Group.fromJson(groupJson),
    );
  }

  static Map<String, List<Team>> teamsByGroup(
    List<GroupTeamDto> dtos,
  ) {
    final Map<String, List<Team>> group = {};

    for (final dto in dtos) {
      final groupName = dto.group.name;

      if (!group.containsKey(groupName)) {
        group[groupName] = [];
      }

      group[groupName]!.add(dto.team);
    }

    return group;
  }
}
