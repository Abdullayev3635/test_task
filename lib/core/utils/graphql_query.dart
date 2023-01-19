mixin GqlQuery {
  static String continentsQuery = '''
  query Query {
    continents {
      code
      name
    }
  }
  ''';
  static String countriesQuery = '''
  query Query {
    countries {
      continent  {
        code
        name
      }
      code
      currency
      emoji
      emojiU
      name
      native
      phone
    }
  }

  ''';
}
