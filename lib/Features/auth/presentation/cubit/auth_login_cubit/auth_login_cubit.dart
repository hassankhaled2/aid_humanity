import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases_impl/login_with_google_use_case.dart';
import '../../../domain/use_cases_impl/post_user_data_use_case.dart';
import 'auth_login_states.dart';

class AuthLoginCubit extends Cubit<AuthLoginState>
{
  AuthLoginCubit(this.callLoginWithGoogleUseCase):super(AuthLoginInitial());
  final CallLoginWithGoogleUseCase callLoginWithGoogleUseCase;

void fetchAuthData() async {
 emit(AuthLoginLoading());
 var result=await callLoginWithGoogleUseCase.call();
print(result);
 result.fold((failure)
 {
   emit(AuthLoginFailure(failure.message));
 },
   (authData)
 {
emit(AuthLoginSuccess(authData));
 });
}
}