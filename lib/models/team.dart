class Team {
  final String name;
  final String flagUrl;
  int totalPartidos;
  int ganados;
  int perdidos;
  int empatados;
  int puntos;

  Team({
    required this.name,
    required this.flagUrl,
    this.totalPartidos = 0,
    this.ganados = 0,
    this.perdidos = 0,
    this.empatados = 0,
    this.puntos = 0,
  });
}
