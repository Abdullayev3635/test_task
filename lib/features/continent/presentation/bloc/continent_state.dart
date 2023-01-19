part of 'continent_bloc.dart';

@immutable
abstract class ContinentState {}

class ContinentInitial extends ContinentState {}

class ContinentLoading extends ContinentState {}

class ContinentLoadedSuccess extends ContinentState {
  final List<ContinentEntity> list;

  ContinentLoadedSuccess({required this.list});
}

class ContinentLoadedFailure extends ContinentState {
  final String message;

  ContinentLoadedFailure({required this.message});
}
