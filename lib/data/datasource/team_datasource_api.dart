import 'dart:convert';

import 'package:futudem_app/models/team.dart';
import 'package:http/http.dart' as http;

class TeamDatasourceApi {
  Future<List<Team>> fetchTeams() async {
    final url = Uri.parse(
      'https://v3.football.api-sports.io/teams?league=39&season=2023',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-host': 'v3.football.api-sports.io',
          'x-apisports-key':
              '625304949b0258ea4140f679c3e21215',
          //
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final results = data['response'] as List;

        return results.map((item) {
          return Team(
            id: item['team']['id'],
            name: item['team']['name'],
            shield: item['team']['logo'],
          );
        }).toList();
      } else {
        throw Exception(
          'Failed to load teams: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load teams: $e');
    }
  }
}

  // You can implement the logic to call the API and return the data


