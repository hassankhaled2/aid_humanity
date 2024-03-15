import 'package:aid_humanity/Features/auth/data/models/user_data_model.dart';

import '../../../domain/entites/user_entity.dart';

abstract class AuthLocalDataSource
{
  Future<UserDataModel>postUserData();
  Future<UserEntity>login();
}
class AuthLocalDataSourceImpl extends AuthLocalDataSource
{
  @override
  Future<UserEntity> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<UserDataModel> postUserData() {
    // TODO: implement postUserData
    throw UnimplementedError();
  }


}