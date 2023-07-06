import 'package:graphql_flutter/graphql_flutter.dart';

class ServerConfig {
  static HttpLink httpLink = HttpLink(
      'https://noted-marlin-89.hasura.app/v1/graphql',
      defaultHeaders: {
        "x-hasura-admin-secret":
            "dliKIkXc6NSuZyOetcN6lxeYDuaUyrk0MfDELNMmytndooVdxxZ7jr0ZSt1CjOhR",
        "content-type": "application/json"
      });

  static GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
}
