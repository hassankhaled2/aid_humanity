import 'package:aid_humanity/Features/auth/domain/entites/user_entity.dart';

abstract class AuthLoginState{}

class AuthLoginInitial extends AuthLoginState{}

class AuthLoginLoading extends AuthLoginState{}
class AuthLoginSuccess extends AuthLoginState
{
final UserEntity userEntity;

  AuthLoginSuccess(this.userEntity);

}
class AuthLoginFailure extends AuthLoginState
{
  final String errorMessage;

  AuthLoginFailure(this.errorMessage);
}