import 'package:futudem_app/models/relations/group_team_dto.dart';
import 'package:futudem_app/models/relations/match_fixture_dto.dart';

class StateGroup {
  final bool loading;
  final String error;
  final List<GroupTeamDto> groupTeams;
  final List<MatchDto> matches;

  StateGroup({
    required this.loading,
    required this.error,
    required this.groupTeams,
    required this.matches,
  });

  factory StateGroup.initial() {
    return StateGroup(
      loading: false,
      error: '',  
      groupTeams: [],
      matches: [],  
    );
  }

  StateGroup copyWith({
    bool? loading,
    String? error,
    List<GroupTeamDto>? groupTeams,
    List<MatchDto>? matches,
  }) {
    return StateGroup(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      groupTeams: groupTeams ?? this.groupTeams,
      matches: matches ?? this.matches,
    );
  }
}