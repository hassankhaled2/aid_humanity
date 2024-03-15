import 'package:aid_humanity/Features/auth/data/models/user_data_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/faliures.dart';
import '../entites/user_entity.dart';

abstract class AuthRepo
{
       Future<Either<Failure,UserDataModel>>postUserData();
       Future<Either<Failure,UserEntity>>login();
}