import 'package:aid_humanity/Features/home/domain/repositories/home_repository.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

class UpdateRequestUseCase {
  final HomeRepository homeRepository;
  UpdateRequestUseCase({
    required this.homeRepository,
  });

  Future<Either<Faliure, Unit>> call({required String requestId,required String userId,required String status}) {
    return homeRepository.updateRequest(requestId, userId, status);
  }
}
