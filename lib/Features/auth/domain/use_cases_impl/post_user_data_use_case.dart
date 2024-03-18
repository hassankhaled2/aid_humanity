import 'package:aid_humanity/Features/auth/domain/repositeries/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/faliures.dart';

import '../../../../core/use_cases/use_case.dart';
import '../../data/models/user_data_model.dart';
import '../entites/user_entity.dart';

class CallPostUserDataUseCase extends UseCase<UserDataModel,NoParam>
{
final AuthRepo authRepo;

  CallPostUserDataUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserDataModel>> call([NoParam ?param]) async {
  return authRepo.postUserData();
  }


}

