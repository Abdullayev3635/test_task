import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientGenerator {
  GraphQLClientGenerator();

  GraphQLClient getClient() {
    final HttpLink httpLink =
        HttpLink('https://countries.trevorblades.com/graphql');
    final AuthLink authLink =
        AuthLink(getToken: () async => 'Bearer ${_getAccessToken()}');
    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
        link: link, cache: GraphQLCache(store: InMemoryStore()));
  }

  String _getAccessToken() {
    return "";
  }
}
