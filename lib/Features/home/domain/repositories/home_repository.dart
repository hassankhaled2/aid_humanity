import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<RequestEntity>>> getAllRequests();
  Future<Either<Failure, List<RequestEntity>>> getLiveRequests(
      String userId, bool isDonor);
  Future<Either<Failure, List<RequestEntity>>> getDoneRequests(
      String userId, bool isDonor);

  Future<Either<Failure, Unit>> updateRequest(
      String requestId, String userId, String status);
}
