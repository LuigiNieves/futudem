class GroupTeam {
  final int groupId;
  final int teamId;

  GroupTeam({
    required this.groupId,
    required this.teamId,
  });

  Map<String, dynamic> toJson() => {
    'group_id': groupId,
    'team_id': teamId,
  };
}
