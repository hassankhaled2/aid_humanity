import 'package:aid_humanity/Features/auth/domain/repositeries/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entites/user_entity.dart';

class postUserDataUseCase
{
final AuthRepo authRepo;

  postUserDataUseCase(this.authRepo);
Future<Either<Failure,List<UserEntity>>>postUserData()
{
 return authRepo.postUserData();
}
}