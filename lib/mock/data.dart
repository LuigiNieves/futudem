import 'package:futudem_app/models/player.dart';
import 'package:futudem_app/models/team.dart';
import 'package:futudem_app/models/match.dart';

final List<Map<String, String>> usuariosRegistrados = [
  {'user': '1', 'pass': '1', 'rol': 'admin'},
  {'user': 'admin1', 'pass': 'admin123', 'rol': 'admin'},
  {'user': 'capitan1', 'pass': 'capitan123', 'rol': 'capitan'},
  {'user': 'capitan2', 'pass': 'futbol2024', 'rol': 'capitan'},
];

final List<Team> mockTeams = [
  Team(id: 1, name: 'Real Madrid', shield: 'https://flagcdn.com/w20/es.png'),
  Team(id: 2, name: 'Barcelona', shield: 'https://flagcdn.com/w20/es.jpg'),
  Team(id: 3, name: 'Manchester City', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 4, name: 'Liverpool', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 5, name: 'Bayern Munich', shield: 'https://flagcdn.com/w20/de.jpg'),
  Team(id: 6, name: 'PSG', shield: 'https://flagcdn.com/w20/fr.jpg'),
  Team(id: 7, name: 'Juventus', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 8, name: 'Chelsea', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 9, name: 'Inter Milan', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 10, name: 'Arsenal', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 11, name: 'Atletico Madrid', shield: 'https://flagcdn.com/w20/es.jpg'),
  Team(id: 12, name: 'AC Milan', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 13, name: 'Dortmund', shield: 'https://flagcdn.com/w20/de.jpg'),
  Team(id: 14, name: 'Napoli', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 15, name: 'Tottenham', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 16, name: 'Ajax', shield: 'https://flagcdn.com/w20/nl.jpg'),
];

final List<Team> groupA = [
  Team(id: 1, name: 'Real Madrid', shield: 'https://flagcdn.com/w20/es.png'),
  Team(id: 2, name: 'Barcelona', shield: 'https://flagcdn.com/w20/es.jpg'),
  Team(id: 3, name: 'Manchester City', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 4, name: 'Liverpool', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 5, name: 'Bayern Munich', shield: 'https://flagcdn.com/w20/de.jpg'),
  Team(id: 6, name: 'PSG', shield: 'https://flagcdn.com/w20/fr.jpg'),
  Team(id: 7, name: 'Juventus', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 8, name: 'Chelsea', shield: 'https://flagcdn.com/w20/gb.jpg'),
];

final List<Team> groupB = [
  Team(id: 9, name: 'Inter Milan', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 10, name: 'Arsenal', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 11, name: 'Atletico Madrid', shield: 'https://flagcdn.com/w20/es.jpg'),
  Team(id: 12, name: 'AC Milan', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 13, name: 'Dortmund', shield: 'https://flagcdn.com/w20/de.jpg'),
  Team(id: 14, name: 'Napoli', shield: 'https://flagcdn.com/w20/it.jpg'),
  Team(id: 15, name: 'Tottenham', shield: 'https://flagcdn.com/w20/gb.jpg'),
  Team(id: 16, name: 'Ajax', shield: 'https://flagcdn.com/w20/nl.jpg'),
];

// final List<Match> mockKnockoutMatches = [
//   Match(homeTeam: groupA[0], awayTeam: groupB[1]),
//   Match(homeTeam: groupA[3], awayTeam: groupB[0]),
//   Match(homeTeam: groupA[5], awayTeam: groupB[4]),
//   Match(homeTeam: groupA[2], awayTeam: groupB[6]),
// ];

// final Map<String, List<Match>> jornadasMap = {
//   "Jornada 1": [
//     Match(homeTeam: groupA[0], awayTeam: groupA[7]), // Real Madrid vs Chelsea
//     Match(homeTeam: groupA[5], awayTeam: groupA[6]), // PSG vs Juventus
//     Match(homeTeam: groupA[3], awayTeam: groupA[4]), // Liverpool vs Bayern
//     Match(homeTeam: groupA[2], awayTeam: groupA[1]), // Man City vs Barcelona
//     Match(homeTeam: groupB[0], awayTeam: groupB[7]), // Inter vs Ajax
//     Match(homeTeam: groupB[5], awayTeam: groupB[6]), // Napoli vs Tottenham
//     Match(homeTeam: groupB[3], awayTeam: groupB[4]), // AC Milan vs Dortmund
//     Match(homeTeam: groupB[1], awayTeam: groupB[2]), // Arsenal vs Atlético
//   ],
//   "Jornada 2": [
//     Match(homeTeam: groupA[7], awayTeam: groupA[5]),
//     Match(homeTeam: groupA[6], awayTeam: groupA[3]),
//     Match(homeTeam: groupA[4], awayTeam: groupA[2]),
//     Match(homeTeam: groupA[1], awayTeam: groupA[0]),
//     Match(homeTeam: groupB[7], awayTeam: groupB[5]),
//     Match(homeTeam: groupB[6], awayTeam: groupB[3]),
//     Match(homeTeam: groupB[4], awayTeam: groupB[1]),
//     Match(homeTeam: groupB[2], awayTeam: groupB[0]),
//   ],
//   "Jornada 3": [
//     Match(homeTeam: groupA[6], awayTeam: groupA[7]),
//     Match(homeTeam: groupA[4], awayTeam: groupA[5]),
//     Match(homeTeam: groupA[1], awayTeam: groupA[3]),
//     Match(homeTeam: groupA[0], awayTeam: groupA[2]),
//     Match(homeTeam: groupB[4], awayTeam: groupB[7]),
//     Match(homeTeam: groupB[2], awayTeam: groupB[5]),
//     Match(homeTeam: groupB[0], awayTeam: groupB[3]),
//     Match(homeTeam: groupB[1], awayTeam: groupB[6]),
//   ],
//   "Jornada 4": [
//     Match(homeTeam: groupA[7], awayTeam: groupA[4]),
//     Match(homeTeam: groupA[5], awayTeam: groupA[1]),
//     Match(homeTeam: groupA[3], awayTeam: groupA[0]),
//     Match(homeTeam: groupA[2], awayTeam: groupA[6]),
//     Match(homeTeam: groupB[7], awayTeam: groupB[2]),
//     Match(homeTeam: groupB[5], awayTeam: groupB[0]),
//     Match(homeTeam: groupB[3], awayTeam: groupB[1]),
//     Match(homeTeam: groupB[6], awayTeam: groupB[4]),
//   ],
//   "Jornada 5": [
//     Match(homeTeam: groupA[1], awayTeam: groupA[7]),
//     Match(homeTeam: groupA[0], awayTeam: groupA[5]),
//     Match(homeTeam: groupA[6], awayTeam: groupA[4]),
//     Match(homeTeam: groupA[3], awayTeam: groupA[2]),
//     Match(homeTeam: groupB[1], awayTeam: groupB[7]),
//     Match(homeTeam: groupB[2], awayTeam: groupB[3]),
//     Match(homeTeam: groupB[0], awayTeam: groupB[4]),
//     Match(homeTeam: groupB[5], awayTeam: groupB[6]),
//   ],
//   "Jornada 6": [
//     Match(homeTeam: groupA[5], awayTeam: groupA[7]),
//     Match(homeTeam: groupA[4], awayTeam: groupA[1]),
//     Match(homeTeam: groupA[6], awayTeam: groupA[0]),
//     Match(homeTeam: groupA[2], awayTeam: groupA[3]),
//     Match(homeTeam: groupB[3], awayTeam: groupB[7]),
//     Match(homeTeam: groupB[4], awayTeam: groupB[5]),
//     Match(homeTeam: groupB[6], awayTeam: groupB[0]),
//     Match(homeTeam: groupB[1], awayTeam: groupB[2]),
//   ],
//   "Jornada 7": [
//     Match(homeTeam: groupA[7], awayTeam: groupA[6]),
//     Match(homeTeam: groupA[1], awayTeam: groupA[4]),
//     Match(homeTeam: groupA[3], awayTeam: groupA[0]),
//     Match(homeTeam: groupA[5], awayTeam: groupA[2]),
//     Match(homeTeam: groupB[3], awayTeam: groupB[7]),
//     Match(homeTeam: groupB[5], awayTeam: groupB[1]),
//     Match(homeTeam: groupB[4], awayTeam: groupB[2]),
//     Match(homeTeam: groupB[0], awayTeam: groupB[6]),
//   ],
// };

final List<Player> playersList = [
  Player(
    id: 1,
    name: 'Carlos Pérez',
    lastName: 'García',
  ),
  Player(
    id: 2 ,
    name: 'Ana Gómez',
    lastName: 'López',
  ),
  Player(
    id: 3,
    name: 'Luis Torres',
    lastName: 'Martínez',
  ),
  Player(
    id: 4,
    name: 'María Rodríguez',
    lastName: 'Sánchez',
  ),
  Player(
    id: 5,
    name: 'Juan Díaz',
    lastName: 'Pérez',
  ),
];
