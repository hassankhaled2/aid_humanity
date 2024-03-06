import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/user_entity.dart';

abstract class AuthRepo
{
       Future<Either<Failure,List<UserEntity>>>postUserData();
       Future<Either<Failure,List<UserEntity>>>loginWithGoogle();
}