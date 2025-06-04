class Team {
  int? id;
  final String name;
  final String shield;
  int pj = 0; 
  int g = 0;  
  int p = 0;  
  int e = 0; 

  Team({
    this.id,
    required this.name,
    required this.shield,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      shield: json['shield'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shield': shield,
    };
  }
}
