
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/team/state_team.dart';
import 'package:futudem_app/controllers/team/team_contoller.dart';
import 'package:futudem_app/data/datasource/team_datasource.dart';
import 'package:futudem_app/data/datasource/team_datasource_api.dart';
import 'package:futudem_app/repositories/team_repository_impl.dart';

final teamControllerProvider = StateNotifierProvider<TeamController, StateTeam>(
  (ref) {
    final datasource = TeamRemoteDatasource();
    final datasourceApi = TeamDatasourceApi();
    final repository = TeamRepositoryImpl(datasource, datasourceApi);

    return TeamController(repository); 
  },
);
