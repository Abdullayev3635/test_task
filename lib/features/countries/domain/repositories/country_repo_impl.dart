import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/country_entity.dart';

abstract class CountryRepositoryImpl {
  Future<Either<Failure, List<CountryEntity>>> getCountry(int page, String code);
}
