part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}

class GetCountryEvent extends CountryEvent {
  final int page;
  final String code;

  GetCountryEvent({required this.page, required this.code});
}

class SearchCountryEvent extends CountryEvent {
  final String text;

  SearchCountryEvent({required this.text});
}

class RemoveCountryEvent extends CountryEvent {
  final CountryEntity countryEntity;

  RemoveCountryEvent({required this.countryEntity});
}
