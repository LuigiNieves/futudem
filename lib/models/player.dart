class Player {
  final int id;
  final String name;
  final String lastName;
  

  Player({
    required this.id,
    required this.name,
    required this.lastName,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
    };
  }



  
}
