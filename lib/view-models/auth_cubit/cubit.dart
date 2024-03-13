import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/models/user_model.dart';
import 'package:mohamed_mounir_assesment/services/auth_service.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthService _authService = AuthService();

  UserModel userModel = UserModel.instance();

  onChangeFullName(String value) {
    userModel.fullName = value;
    emit(OnChangeState());
  }

  onChangeEmailAddress(String value) {
    userModel.email = value;
    emit(OnChangeState());
  }

  onChangePassword(String value) {
    userModel.password = value;
    emit(OnChangeState());
  }

  logIn() {
    emit(LogInLoadingState());
    _authService
        .login(email: userModel.email, password: userModel.password)
        .then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  loginWithGoogle() {
    emit(LogInLoadingState());
    _authService.loginWithGoogle().then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  loginWithFacebook() {
    emit(LogInLoadingState());
    _authService.loginWithFacebook().then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  registerUser() {
    emit(RegisterLoadingState());
    _authService.register(model: userModel).then((value) async {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error: error.message));
    });
  }

  logOut() {
    _authService.logOut();
  }
}
