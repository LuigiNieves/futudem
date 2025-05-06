import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/match.dart';

final List<Map<String, String>> usuariosRegistrados = [
  {'user': 'admin1', 'pass': 'admin123', 'rol': 'admin'},
  {'user': 'capitan1', 'pass': 'capitan123', 'rol': 'capitan'},
  {'user': 'capitan2', 'pass': 'futbol2024', 'rol': 'capitan'},
];

final List<Team> mockTeams = [
  Team(name: 'Real Madrid', flagUrl: 'https://flagcdn.com/w20/es.png'),
  Team(name: 'Barcelona', flagUrl: 'https://flagcdn.com/w20/es.jpg'),
  Team(name: 'Manchester City', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Liverpool', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Bayern Munich', flagUrl: 'https://flagcdn.com/w20/de.jpg'),
  Team(name: 'PSG', flagUrl: 'https://flagcdn.com/w20/fr.jpg'),
  Team(name: 'Juventus', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Chelsea', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Inter Milan', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Arsenal', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Atletico Madrid', flagUrl: 'https://flagcdn.com/w20/es.jpg'),
  Team(name: 'AC Milan', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Dortmund', flagUrl: 'https://flagcdn.com/w20/de.jpg'),
  Team(name: 'Napoli', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Tottenham', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Ajax', flagUrl: 'https://flagcdn.com/w20/nl.jpg'),
];

final List<Team> groupA = [
  Team(name: 'Real Madrid', flagUrl: 'https://flagcdn.com/w20/es.png'),
  Team(name: 'Barcelona', flagUrl: 'https://flagcdn.com/w20/es.jpg'),
  Team(name: 'Manchester City', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Liverpool', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Bayern Munich', flagUrl: 'https://flagcdn.com/w20/de.jpg'),
  Team(name: 'PSG', flagUrl: 'https://flagcdn.com/w20/fr.jpg'),
  Team(name: 'Juventus', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Chelsea', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
];

final List<Team> groupB = [
  Team(name: 'Inter Milan', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Arsenal', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Atletico Madrid', flagUrl: 'https://flagcdn.com/w20/es.jpg'),
  Team(name: 'AC Milan', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Dortmund', flagUrl: 'https://flagcdn.com/w20/de.jpg'),
  Team(name: 'Napoli', flagUrl: 'https://flagcdn.com/w20/it.jpg'),
  Team(name: 'Tottenham', flagUrl: 'https://flagcdn.com/w20/gb.jpg'),
  Team(name: 'Ajax', flagUrl: 'https://flagcdn.com/w20/nl.jpg'),
];

final List<Match> mockKnockoutMatches = [
  Match(homeTeam: groupA[0], awayTeam: groupB[1]),
  Match(homeTeam: groupA[3], awayTeam: groupB[0]),
  Match(homeTeam: groupA[5], awayTeam: groupB[4]),
  Match(homeTeam: groupA[2], awayTeam: groupB[6]),
];

final Map<String, List<Match>> jornadasMap = {
  "Jornada 1": [
    Match(homeTeam: groupA[0], awayTeam: groupA[7]), // Real Madrid vs Chelsea
    Match(homeTeam: groupA[5], awayTeam: groupA[6]), // PSG vs Juventus
    Match(homeTeam: groupA[3], awayTeam: groupA[4]), // Liverpool vs Bayern
    Match(homeTeam: groupA[2], awayTeam: groupA[1]), // Man City vs Barcelona
    Match(homeTeam: groupB[0], awayTeam: groupB[7]), // Inter vs Ajax
    Match(homeTeam: groupB[5], awayTeam: groupB[6]), // Napoli vs Tottenham
    Match(homeTeam: groupB[3], awayTeam: groupB[4]), // AC Milan vs Dortmund
    Match(homeTeam: groupB[1], awayTeam: groupB[2]), // Arsenal vs Atlético
  ],
  "Jornada 2": [
    Match(homeTeam: groupA[7], awayTeam: groupA[5]),
    Match(homeTeam: groupA[6], awayTeam: groupA[3]),
    Match(homeTeam: groupA[4], awayTeam: groupA[2]),
    Match(homeTeam: groupA[1], awayTeam: groupA[0]),
    Match(homeTeam: groupB[7], awayTeam: groupB[5]),
    Match(homeTeam: groupB[6], awayTeam: groupB[3]),
    Match(homeTeam: groupB[4], awayTeam: groupB[1]),
    Match(homeTeam: groupB[2], awayTeam: groupB[0]),
  ],
  "Jornada 3": [
    Match(homeTeam: groupA[6], awayTeam: groupA[7]),
    Match(homeTeam: groupA[4], awayTeam: groupA[5]),
    Match(homeTeam: groupA[1], awayTeam: groupA[3]),
    Match(homeTeam: groupA[0], awayTeam: groupA[2]),
    Match(homeTeam: groupB[4], awayTeam: groupB[7]),
    Match(homeTeam: groupB[2], awayTeam: groupB[5]),
    Match(homeTeam: groupB[0], awayTeam: groupB[3]),
    Match(homeTeam: groupB[1], awayTeam: groupB[6]),
  ],
  "Jornada 4": [
    Match(homeTeam: groupA[7], awayTeam: groupA[4]),
    Match(homeTeam: groupA[5], awayTeam: groupA[1]),
    Match(homeTeam: groupA[3], awayTeam: groupA[0]),
    Match(homeTeam: groupA[2], awayTeam: groupA[6]),
    Match(homeTeam: groupB[7], awayTeam: groupB[2]),
    Match(homeTeam: groupB[5], awayTeam: groupB[0]),
    Match(homeTeam: groupB[3], awayTeam: groupB[1]),
    Match(homeTeam: groupB[6], awayTeam: groupB[4]),
  ],
  "Jornada 5": [
    Match(homeTeam: groupA[1], awayTeam: groupA[7]),
    Match(homeTeam: groupA[0], awayTeam: groupA[5]),
    Match(homeTeam: groupA[6], awayTeam: groupA[4]),
    Match(homeTeam: groupA[3], awayTeam: groupA[2]),
    Match(homeTeam: groupB[1], awayTeam: groupB[7]),
    Match(homeTeam: groupB[2], awayTeam: groupB[3]),
    Match(homeTeam: groupB[0], awayTeam: groupB[4]),
    Match(homeTeam: groupB[5], awayTeam: groupB[6]),
  ],
  "Jornada 6": [
    Match(homeTeam: groupA[5], awayTeam: groupA[7]),
    Match(homeTeam: groupA[4], awayTeam: groupA[1]),
    Match(homeTeam: groupA[6], awayTeam: groupA[0]),
    Match(homeTeam: groupA[2], awayTeam: groupA[3]),
    Match(homeTeam: groupB[3], awayTeam: groupB[7]),
    Match(homeTeam: groupB[4], awayTeam: groupB[5]),
    Match(homeTeam: groupB[6], awayTeam: groupB[0]),
    Match(homeTeam: groupB[1], awayTeam: groupB[2]),
  ],
  "Jornada 7": [
    Match(homeTeam: groupA[7], awayTeam: groupA[6]),
    Match(homeTeam: groupA[1], awayTeam: groupA[4]),
    Match(homeTeam: groupA[3], awayTeam: groupA[0]),
    Match(homeTeam: groupA[5], awayTeam: groupA[2]),
    Match(homeTeam: groupB[3], awayTeam: groupB[7]),
    Match(homeTeam: groupB[5], awayTeam: groupB[1]),
    Match(homeTeam: groupB[4], awayTeam: groupB[2]),
    Match(homeTeam: groupB[0], awayTeam: groupB[6]),
  ],
};

final List<Player> playersList = [
  Player(
    id: 'p1',
    name: 'Carlos Pérez',
    career: 'Ingeniería de Sistemas',
    isCaptain: true,
    isApproved:true
  ),
  Player(
    id: 'p2',
    name: 'Ana Gómez',

    career: 'Medicina',
    isApproved:true
  ),
  Player(
    id: 'p3',
    name: 'Luis Torres',
    career: 'Arquitectura',
    isApproved:true
  ),
  Player(
    id: 'p4',
    name: 'María Rodríguez',
    career: 'Psicología',
    isApproved:true
  ),
  Player(
    id: 'p5',
    name: 'Juan Díaz',
    career: 'Administración de Empresas',
  ),
];
