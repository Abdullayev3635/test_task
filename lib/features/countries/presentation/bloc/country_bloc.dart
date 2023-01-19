import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/usescases/usescase.dart';

part 'country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final UsesCountry usesCountry;

  CountryBloc({required this.usesCountry}) : super(CountryInitial()) {
    on<GetCountryEvent>(getCountry, transformer: sequential());
    on<SearchCountryEvent>(searchCountry, transformer: sequential());
  }

  List<CountryEntity> listNew = [];
  List<CountryEntity> listOld = [];

  FutureOr<void> getCountry(
      GetCountryEvent event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    final result =
        await usesCountry(CountryParams(page: event.page, code: event.code));
    result.fold(
        (failure) => {
              if (failure is ConnectionFailure)
                {emit(CountryLoadedFailure(message: failure.message))}
              else if (failure is ServerFailure)
                {
                  emit(CountryLoadedFailure(
                    message: failure.message,
                  ))
                }
            },
        (r) => {
              emit(CountryLoadedSuccess(list: r)),
              listNew.addAll(r),
              listOld.addAll(r)
            });
  }

  FutureOr<void> searchCountry(
      SearchCountryEvent event, Emitter<CountryState> emit) {
    listNew = listOld;
    if (event.text.isEmpty) {
      emit(CountryLoadedSuccess(list: listOld));
    } else {
      emit(CountryLoadedSuccess(
          list: listNew.where((element) {
        final titleLower = element.name!.toLowerCase();
        final searchLower = event.text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList()));
    }
  }
}
