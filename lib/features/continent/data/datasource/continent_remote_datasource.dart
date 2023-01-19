import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

import '../../../../core/utils/graphql_query.dart';

abstract class ContinentRemoteDatasource {
  Future<List<ContinentModel>> getContinent();
}

class ContinentRemoteDatasourceImpl extends ContinentRemoteDatasource {
  final GraphQLClient _client;

  ContinentRemoteDatasourceImpl(this._client);

  @override
  Future<List<ContinentModel>> getContinent() async {
    try {
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.continentsQuery),
      ));
      if (result.data == null) {
        return [];
      }
      return result.data?['continents']
          .map((e) => ContinentModel.fromJson(e))
          .cast<ContinentModel>()
          .toList();
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return [];
    }
  }
}
