import 'package:dartz/dartz.dart';
import 'package:uic_task/core/error/failures.dart';
import 'package:uic_task/features/countries/data/datasource/country_local_datasource.dart';
import 'package:uic_task/features/countries/data/modal/country_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/country_repo_impl.dart';
import '../datasource/country_remote_datasource.dart';

class CountryRepository implements CountryRepositoryImpl {
  final CountryRemoteDatasourceImpl remoteDatasource;
  final CountryLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  CountryRepository({
    required this.networkInfo,
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountry(
      int page, String code) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await remoteDatasource.getCountry(page, code);
        final entities =
            models.map<CountryEntity>((e) => e.toEntity()).toList();
        await localDatasource.cacheCountry(models);
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure("Serverga boglanishda xatolik yuz berdi"));
      }
    } else {
      try {
        final models = localDatasource.getCountry();
        final entities =
            models.map<CountryEntity>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure("Cech xotirada malumot yoq"));
      }
    }
  }

// @override
// Future<Either<Failure, dynamic>> getValidatePhone(
//     String validatePhone) async {
//   if (await networkInfo.isConnected) {
//     try {
//       final result = await remoteDatasource.validatePhoneClient(
//           validatePhone: validatePhone);
//       return Right(result);
//     } on ServerFailure {
//       return const Left(ServerFailure("Маълумот юкланишда хатолик бўлди"));
//     }
//   } else {
//     return const Left(LocalFailure("Маълумот юкланишда хатолик бўлди"));
//   }
// }
}
