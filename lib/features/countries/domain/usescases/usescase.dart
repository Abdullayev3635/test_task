import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usescases/usecase.dart';
import '../entities/country_entity.dart';
import '../repositories/country_repo_impl.dart';

class UsesCountry extends UseCase<List<CountryEntity>, CountryParams> {
  final CountryRepositoryImpl countryRepositoryImpl;

  UsesCountry({required this.countryRepositoryImpl});

  @override
  Future<Either<Failure, List<CountryEntity>>> call(CountryParams params) {
    return countryRepositoryImpl.getCountry(params.page, params.code);
  }
}

class CountryParams extends Equatable {
  final int page;
  final String code;

  const CountryParams({required this.page, required this.code});

  @override
  List<Object?> get props => [];
}
