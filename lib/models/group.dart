
class Group {
  final int id;
  final String name;
  final int tournamentId;

  Group({
    required this.id,
    required this.name,
    required this.tournamentId,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int,
      name: json['name'] as String ,
      tournamentId: json['tournament_id']  as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tournament_id': tournamentId,
    };
  }
}

