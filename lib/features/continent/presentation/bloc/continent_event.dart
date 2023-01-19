part of 'continent_bloc.dart';

@immutable
abstract class ContinentEvent {}

class GetContinentEvent extends ContinentEvent {}

class GetContinentEventRefresh extends ContinentEvent {}
