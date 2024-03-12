 import '../../../domain/entites/user_entity.dart';

abstract class LoginRemoteDataSource
 {

    Future<UserEntity>postUserData();
    Future<UserEntity>loginWithGoogle();
 }
 class LoginRemoteDataSourceImpl extends LoginRemoteDataSource
 {
  @override
  Future<UserEntity> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> postUserData() {
    // TODO: implement postUserData
    throw UnimplementedError();
  }

 }