import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entites/user_entity.dart';

abstract class AuthRepo
{
       Future<Either<Failure,UserEntity>>postUserData();
       Future<Either<Failure,UserEntity>>loginWithGoogle();
}