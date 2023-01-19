part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}


class CountryLoading extends CountryState {}

class CountryLoadedSuccess extends CountryState {
  final List<CountryEntity> list;

  CountryLoadedSuccess({required this.list});
}

class CountryLoadedFailure extends CountryState {
  final String message;

  CountryLoadedFailure({required this.message});
}
