import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
    List<CountryModel> list = [];
    try {
      final result = await _client.query(QueryOptions(
        document: gql(GqlQuery.countriesQuery),
      ));
      if (result.data == null) {
        return [];
      }
      list = result.data?['countries']
          .map((e) => CountryModel.fromJson(e))
          .cast<CountryModel>()
          .toList();
      return list;
    } on Exception catch (exception) {
      debugPrint(exception.toString());
      return [];
    }
  }
}
