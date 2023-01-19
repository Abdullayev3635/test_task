import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uic_task/features/continent/domain/entities/continent_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usescases/usecase.dart';
import '../repositories/continent_repo_impl.dart';

class UsesContinent extends UseCase<List<ContinentEntity>, ContinentParams> {
  final ContinentRepositoryImpl continentRepository;

  UsesContinent({required this.continentRepository});

  @override
  Future<Either<Failure, List<ContinentEntity>>> call(ContinentParams params) {
    return continentRepository.getContinent();
  }
}

class ContinentParams extends Equatable {
  @override
  List<Object?> get props => [];
}
