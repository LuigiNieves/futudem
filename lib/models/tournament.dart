
class Tournament {
  final int? id;
  final String name;
  final String startDate;

  Tournament({
    required this.id,
    required this.name,
    required this.startDate,
  });

   

  factory Tournament.fromJson(Map<String, dynamic> json) {

    return Tournament(
      id: json['id'] as int? ?? 0, // Asignar un valor por defecto si es null
      name: json['name'] as String? ?? '',
      startDate: json['start_date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'start_date': startDate,
    };
  }
}