import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Faliure, List<RequestEntity>>> getAllRequests();
  Future<Either<Faliure,List<RequestEntity>>> getLiveRequests(String userId);
   Future<Either<Faliure,List<RequestEntity>>> getDoneRequests(String userId);
  
  Future<Either<Faliure,Unit>>updateRequest(String requestId,String userId,String status);

}