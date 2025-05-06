class Player {
  final String id;
  final String name;
  final String career;
  final bool isCaptain;
  final bool isApproved;

  Player({
    required this.id,
    required this.name,
 
    required this.career,
    this.isCaptain = false,
    this.isApproved = false,
  });

  
}
