import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uic_task/core/error/exceptions.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

const String continents = 'continents';

abstract class ContinentLocalDatasource {
  List<ContinentModel> getContinent();

  Future<void> cacheContinent(List<ContinentModel> models);
}

class ContinentLocalDataSourceImpl implements ContinentLocalDatasource {
  ContinentLocalDataSourceImpl();

  final _box = Hive.box<dynamic>("uic-group_task-continent");

  @override
  List<ContinentModel> getContinent() {
    final modelsString = _box.get(continents);
    if (modelsString == null) {
      throw ServerException();
    }
    return json
        .decode(modelsString)
        .map<ContinentModel>((e) => ContinentModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheContinent(List<ContinentModel> models) {
    return _box.put(
      continents,
      json.encode(models.map((e) => e.toJson()).toList()),
    );
  }
}
