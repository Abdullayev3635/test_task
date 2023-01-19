import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

import '../../../../core/utils/graphql_query.dart';
import '../modal/country_model.dart';

abstract class CountryRemoteDatasource {
  Future<List<CountryModel>> getCountry(int page, String code);
}

class CountryRemoteDatasourceImpl extends CountryRemoteDatasource {
  final GraphQLClient _client;

  CountryRemoteDatasourceImpl(this._client);

  @override
  Future<List<CountryModel>> getCountry(int page, String code) async {
    try {
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.countriesQuery),
        variables: {"code": code},
      ));
      if (result.data == null) {
        return [];
      }
      return result.data?['countries']
          .map((e) => CountryModel.fromJson(e))
          .cast<CountryModel>()
          .toList();
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return [];
    }
  }
}
