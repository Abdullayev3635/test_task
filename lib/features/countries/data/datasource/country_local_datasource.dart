import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uic_task/core/error/exceptions.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

import '../modal/country_model.dart';

const String continents = 'continents';

abstract class CountryLocalDatasource {
  List<CountryModel> getCountry();

  Future<void> cacheCountry(List<CountryModel> models);
}

class CountryLocalDataSourceImpl implements CountryLocalDatasource {
  CountryLocalDataSourceImpl();

  final _box = Hive.box<dynamic>("uic-group_task-country");

  @override
  List<CountryModel> getCountry() {
    final modelsString = _box.get(continents);
    if (modelsString == null) {
      throw ServerException();
    }
    return json
        .decode(modelsString)
        .map<CountryModel>((e) => CountryModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> cacheCountry(List<CountryModel> models) {
    return _box.put(
      continents,
      json.encode(models.map((e) => e.toJson()).toList()),
    );
  }
}
