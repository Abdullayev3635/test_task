import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:uic_task/core/error/failures.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';
import 'package:uic_task/features/continent/domain/usescases/usescase.dart';

import '../../domain/entities/continent_entity.dart';

part 'continent_event.dart';

part 'continent_state.dart';

class ContinentBloc extends Bloc<ContinentEvent, ContinentState> {
  final UsesContinent usesContinent;

  ContinentBloc({required this.usesContinent}) : super(ContinentInitial()) {
    on<GetContinentEvent>(getContinent, transformer: sequential());
    on<GetContinentEventRefresh>(getContinentRefresh, transformer: sequential());
  }

  FutureOr<void> getContinent(
      GetContinentEvent event, Emitter<ContinentState> emit) async {
    emit(ContinentLoading());
    final result = await usesContinent(ContinentParams());
    result.fold(
        (failure) => {
              if (failure is ConnectionFailure)
                {
                  emit(ContinentLoadedFailure(
                    message: failure.message,
                  ))
                }
              else if (failure is ServerFailure)
                {
                  emit(ContinentLoadedFailure(
                    message: "",
                  ))
                }
            },
        (r) => {emit(ContinentLoadedSuccess(list: r))});
  }
  FutureOr<void> getContinentRefresh(
      GetContinentEventRefresh event, Emitter<ContinentState> emit) async {
    final result = await usesContinent(ContinentParams());
    result.fold(
        (failure) => {
              if (failure is ConnectionFailure)
                {
                  emit(ContinentLoadedFailure(
                    message: failure.message,
                  ))
                }
              else if (failure is ServerFailure)
                {
                  emit(ContinentLoadedFailure(
                    message: "",
                  ))
                }
            },
        (r) => {emit(ContinentLoadedSuccess(list: r))});
  }
}
