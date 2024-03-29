import 'package:aid_humanity/Features/auth/domain/repositeries/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

import '../../../../core/use_cases/use_case.dart';
import '../entites/user_entity.dart';

class CallPostUserDataUseCase extends UseCase<UserEntity,NoParam>
{
final AuthRepo authRepo;

  CallPostUserDataUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call([NoParam ?param]) async {
  return authRepo.postUserData();
  }


}

