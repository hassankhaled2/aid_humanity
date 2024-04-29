import 'package:aid_humanity/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:aid_humanity/Features/home/data/data_sources/remote_data_source.dart';
import 'package:aid_humanity/Features/home/domain/repositories/home_repository.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:aid_humanity/core/network/connection/network_connection.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  final ConnctionInfo networkInfo;
  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<RequestEntity>>> getAllRequests() async {
    if (await networkInfo.isConnected) {
      try {
        return right(await homeRemoteDataSource.getAllRequests());
      } on ServerException {
        return left(ServerFaliure(""));
      } on NoDataExecption {
        return left(NoDataFaliure(""));
      }
    } else {
      return Left(OfflineFaliure(""));
    }
  }

  @override
  Future<Either<Failure, List<RequestEntity>>> getLiveRequests(String userId,bool isDonor) async {
    if (await networkInfo.isConnected) {
      try {
        return right(await homeRemoteDataSource.getLiveRequests(userId,isDonor));
      } on ServerException {
        return left(ServerFaliure(""));
      } on NoDataExecption {
        return left(NoDataFaliure(""));
      }
    } else {
      return Left(OfflineFaliure(""));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateRequest(String requestId, String userId, String status) async {
    if (await networkInfo.isConnected) {
      try {
        return right(await homeRemoteDataSource.updateRequest(requestId, userId, status));
      } on ServerException {
        return left(ServerFaliure(""));
      }
    } else {
      return Left(OfflineFaliure(""));
    }
  }
  
  @override
  Future<Either<Failure, List<RequestEntity>>> getDoneRequests(String userId,bool isDonor) async{
      if (await networkInfo.isConnected) {
      try {
        return right(await homeRemoteDataSource.getDoneRequests(userId,isDonor));
      } on ServerException {
        return left(ServerFaliure(""));
      } on NoDataExecption {
        return left(NoDataFaliure(""));
      }
    } else {
      return Left(OfflineFaliure(""));
    }
  }
}
