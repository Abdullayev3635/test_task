import 'package:dartz/dartz.dart';
import 'package:uic_task/core/error/failures.dart';
import 'package:uic_task/features/continent/data/datasource/continent_local_datasource.dart';
import 'package:uic_task/features/continent/data/modal/continent_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/continent_entity.dart';
import '../../domain/repositories/continent_repo_impl.dart';
import '../datasource/continent_remote_datasource.dart';

class ContinentRepository implements ContinentRepositoryImpl {
  final ContinentRemoteDatasourceImpl remoteDatasource;
  final ContinentLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  ContinentRepository({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<ContinentEntity>>> getContinent() async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDatasource.getContinent();
        final entities =
            models.map<ContinentEntity>((e) => e.toEntity()).toList();
        await localDatasource.cacheContinent(models);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure("Serverga boglanishda xatolik yuz berdi"));
      }
    } else {
      try {
        final models = localDatasource.getContinent();
        final entities =
            models.map<ContinentEntity>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure("Cech xotirada malumot yoq"));
      }
    }
  }

}
