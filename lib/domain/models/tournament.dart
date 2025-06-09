
class Tournament {
  final int id;
  final String name;
  final String startDate;
  final bool isActive;

  Tournament({
    required this.id,
    required this.name,
    required this.startDate,
    required this.isActive,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {

    return Tournament(
      id: json['id'] as int, 
      name: json['name'] as String,
      startDate: json['start_date'] as String,
      isActive: json['active'] as bool, // Default to false if not provided

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate,
      'active': isActive, // Include isActive in the JSON representation

    };
  }
}