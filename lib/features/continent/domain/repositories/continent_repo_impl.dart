import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/modal/continent_model.dart';
import '../entities/continent_entity.dart';

abstract class ContinentRepositoryImpl {
  Future<Either<Failure, List<ContinentEntity>>> getContinent();
}
