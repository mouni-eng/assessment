class AuthStates {}

class OnChangeState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  String? error;
  RegisterErrorState({this.error});
}

class LogInLoadingState extends AuthStates {}

class LogInSuccessState extends AuthStates {}

class LogInErrorState extends AuthStates {
  String? error;
  LogInErrorState({this.error});
}
