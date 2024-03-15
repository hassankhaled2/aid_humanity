import 'package:aid_humanity/Features/auth/data/data_sources/login_remote_data_source/auth_remote_data_source.dart';
import 'package:aid_humanity/Features/auth/data/models/user_data_model.dart';
import 'package:aid_humanity/Features/auth/domain/entites/user_entity.dart';
import 'package:aid_humanity/Features/auth/domain/repositeries/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/faliures.dart';
import '../../../../core/network/connection/network_connection.dart';
import '../../../onBoarding/onboarding.dart';

class AuthRepoImpl extends AuthRepo
{
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnctionInfo networkInfo;
  AuthRepoImpl({
    required this.authRemoteDataSource,
   required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserEntity>> login()async{
    try {
      UserDataModel userDataModel=await authRemoteDataSource.login();
      return Future.value(Right(userDataModel));
    } catch (exception) {
      return Left(ServerFaliure());
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> postUserData() {
    // TODO: implement postUserData
    throw UnimplementedError();
  }





}