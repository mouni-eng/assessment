import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/models/user_model.dart';
import 'package:mohamed_mounir_assesment/services/auth_service.dart';
import 'package:mohamed_mounir_assesment/view-models/app_cubit/states.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/logIn_view.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/home_view.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  UserModel? user;

  getUser() {
    emit(GetUserDataLoadingState());
    _authService.getUser().then((value) {
      user = value;
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState(error: error.toString()));
    });
  }

  Widget currentView() {
    if (user != null) {
      return const HomeView();
    } else {
      return LoginView();
    }
  }
}
