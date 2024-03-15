import 'package:aid_humanity/Features/home/domain/repositories/home_repository.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

class GetAllRequestsUseCase {
  HomeRepository homeRepository;
  GetAllRequestsUseCase({
    required this.homeRepository,
  });
  Future<Either<Failure, List<RequestEntity>>> call() async {
   return homeRepository.getAllRequests();
  }
}
