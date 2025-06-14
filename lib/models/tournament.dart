
class Tournament {
  final int? id;
  final String name;
  final String startDate;
  final bool isActive;

  Tournament({
    this.id,
    required this.name,
    required this.startDate,
    required this.isActive,
  });

  Tournament copyWith({
    int? id,
    String? name,
    String? startDate,
    bool? isActive,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
    );
  }

  factory Tournament.fromJson(Map<String, dynamic> json) {

    return Tournament(
      id: json['id'] as int, 
      name: json['name'] as String,
      startDate: json['start_date'] as String,
      isActive: json['active'] as bool

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_date': startDate,
      'active': isActive,
    };
  }
}