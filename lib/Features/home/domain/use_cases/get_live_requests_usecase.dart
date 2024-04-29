import 'package:aid_humanity/Features/home/domain/repositories/home_repository.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

class GetLiveRequestsUseCase {
  final HomeRepository homeRepository;
  GetLiveRequestsUseCase({
    required this.homeRepository,
  });
  Future<Either<Failure, List<RequestEntity>>> call({required String userId,required bool isDonor}) {
    return homeRepository.getLiveRequests(userId,isDonor);
  }
}
