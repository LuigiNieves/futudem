

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futudem_app/controllers/group/group_controller.dart';
import 'package:futudem_app/controllers/group/state_group.dart';
import 'package:futudem_app/data/datasource/group_datasource.dart';
import 'package:futudem_app/repositories/group_repository_impl.dart';

final groupControllerProvider = StateNotifierProvider<GroupController, StateGroup>(
  (ref){
    final dataSource = GroupRemoteDatasource();
    final repository = GroupRepositoryImpl(dataSource );

    return GroupController(repository);
  }
);



