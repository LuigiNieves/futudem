import 'package:futudem_app/models/team.dart';

class Match {
  final Team homeTeam;
  final Team awayTeam;
  DateTime? date;
  int? homeGoals;
  int? awayGoals;
  Match({required this.homeTeam, required this.awayTeam, this.date,
  this.homeGoals, this.awayGoals});
}
