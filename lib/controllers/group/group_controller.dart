import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/group/state_group.dart';
import 'package:futudem_app/models/group.dart';
import 'package:futudem_app/models/match.dart';
import 'package:futudem_app/models/repositories/group_repository.dart';
import 'package:futudem_app/models/team.dart';

class GroupController extends StateNotifier<StateGroup> {
  final GroupRepository _repository;

  GroupController(this._repository)
    : super(StateGroup.initial());

  Future<void> loadGroups(int tournamentId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final groups = await _repository.fetchTeamsWithGroups(
        tournamentId,
      );
      state = state.copyWith(
        loading: false,
        groupTeams: groups,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<List<Group>> fetchAllGroups(int tournamentId) {
    return _repository.fetchAllGroups(tournamentId);
  }

  Future<List<Group>> createGroups(int tournamentId) {
    return _repository.createGroups(tournamentId);
  }

  Future<void> assignTeamsToGroups(
    int tournamentId,
    int groupId,
    List<Team> teams,
  ) {
    return _repository.assignTeamsToGroups(
      tournamentId,
      groupId,
      teams,
    );
  }

  Future<void> assignTeamsRandomly(
    int tournamentId,
    List<Team> teams,
  ) async {
    state = state.copyWith(loading: true, error: '');

    try {
      final groups = await _repository.fetchAllGroups(
        tournamentId,
      );
      for (var group in groups) {
        print(
          'Grouppp: ${group.name} with ID: ${group.id}',
        );
      }

      // Mezclar los equipos aleatoriamente
      teams.shuffle();

      final mid = (teams.length / 2).ceil();

      final groupA = groups[0];
      final groupB = groups[1];

      final groupATeams = teams.sublist(0, mid);
      final groupBTeams = teams.sublist(mid);

      print(
        'Group A Teams: ${groupATeams.map((team) => team.name).join(', ')}',
      );
      print(
        'Group B Teams: ${groupBTeams.map((team) => team.name).join(', ')}',
      );

      await assignTeamsToGroups(
        tournamentId,
        groupA.id,
        groupATeams,
      );
      await assignTeamsToGroups(
        tournamentId,
        groupB.id,
        groupBTeams,
      );
    } catch (e) {
      print('Error assigning teams randomly: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchTeamsWithGroups(
    int tournamentId,
  ) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final groupTeams = await _repository
          .fetchTeamsWithGroups(tournamentId);
      print(
        'Teams with groups fetched: ${groupTeams.length} teams',
      );

      state = state.copyWith(
        loading: false,
        groupTeams: groupTeams,
      );
    } catch (e) {
      print('Error fetching teams with groups: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  // match

  Future<void> loadMatches(int tournamentId) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final matches = await _repository
          .fetchGroupsWithMatches(tournamentId);
      print('Matches fetched: ${matches.length}');

      state = state.copyWith(
        loading: false,
        matches: matches,
      );
    } catch (e) {
      print('Error fetching matches: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> fetchMatchesByTournament(
    int tournamentId,
  ) async {
    state = state.copyWith(loading: true, error: '');
    try {
      final matches = await _repository
          .fetchGroupsWithMatches(tournamentId);
      print('Matches fetched: ${matches.length}');

      state = state.copyWith(
        loading: false,
        matches: matches,
      );
    } catch (e) {
      print('Error fetching matches: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createMatch(
    MatchFixture matchFixture,
  ) async {
    state = state.copyWith(loading: true, error: '');

    try {
      await _repository.createMatch(matchFixture);
      print(
        'Match created: HomeTeamId ${matchFixture.homeTeamId} vs AwayTeamId ${matchFixture.awayTeamId}',
      );
    } catch (e) {
      print('Error creating match: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateMatch(
    MatchFixture matchFixture,
  ) async {
    state = state.copyWith(
      loading: true,
      error: '',
      matches: state.matches.map((matchDto) {
        if (matchDto.match.id == matchFixture.id) {
          return matchDto.copyWith(
            match: matchDto.match.copyWith(
              homeTeam: matchFixture.homeTeamId,
              awayTeam: matchFixture.awayTeamId,
              matchDate: matchFixture.matchDate,
              journey: matchFixture.journey,
              groupId: matchFixture.groupId,
            ),
          );
        }
        return matchDto;
      }).toList(),

    );

    try {
      await _repository.updateMatch(matchFixture);
      print(
        'Match updated: HomeTeamId ${matchFixture.homeTeamId} vs AwayTeamId ${matchFixture.awayTeamId}',
      );
    } catch (e) {
      print('Error updating match: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> createMatchesForTournament(
    int tournamentId,
  ) async {
    state = state.copyWith(loading: true, error: '');

    try {
      final groupTeamsDto = await _repository
          .fetchTeamsWithGroups(tournamentId);
      // Agrupar los equipos por nombre de grupo
      final Map<String, List<dynamic>> teamsGrouped = {};
      for (final dto in groupTeamsDto) {
        final groupName = dto.group.name;
        teamsGrouped
            .putIfAbsent(groupName, () => [])
            .add(dto.team);
      }

      for (final entry in teamsGrouped.entries) {
        final teams = entry.value;

        for (int i = 0; i < teams.length; i++) {
          for (int j = i + 1; j < teams.length; j++) {
            final teamA = teams[i];
            final teamB = teams[j];

            final homeTeam =
                (i + j) % 2 == 0 ? teamA : teamB;
            final awayTeam =
                (homeTeam == teamA) ? teamB : teamA;

            final group =
                groupTeamsDto
                    .firstWhere(
                      (dto) =>
                          dto.team.id == homeTeam.id ||
                          dto.team.id == awayTeam.id,
                    )
                    .group;

            final matchFixture = MatchFixture(
              journey: 'Jornada ${(j + 1) - (i + 1)}',
              groupId: group.id,
              homeTeamId: homeTeam.id,
              awayTeamId: awayTeam.id,
              matchDate: DateTime.now(),
            );

            await _repository.createMatch(matchFixture);

            print(
              'Partido creado: ${homeTeam.name} vs ${awayTeam.name} en grupo ${group.name}',
            );
          }
        }
      }

      state = state.copyWith(loading: false);
    } catch (e) {
      print('Error al crear partidos: $e');
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }
}
