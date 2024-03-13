import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/infrastructure/alert_dialog.dart';
import 'package:mohamed_mounir_assesment/infrastructure/utils.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/states.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/widgets/password_bullet.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/home_view.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_button.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_formField.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_navigation.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is RegisterErrorState) {
        AlertService.showSnackbarAlert(
          state.error.toString(),
          SnackbarType.error,
          context,
        );
      } else if (state is RegisterSuccessState) {
        navigateTo(
          view: const HomeView(),
          context: context,
        );
      }
    }, builder: (context, state) {
      AuthCubit cubit = AuthCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: CustomText(fontSize: width(16), text: "Sign up"),
        ),
        body: SafeArea(
            child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height(25),
                  ),
                  CustomFormField(
                    onChange: (value) {
                      cubit.onChangeFullName(value);
                    },
                    hintText: "Full Name",
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomFormField(
                    type: TextInputType.emailAddress,
                    validate: (value) => Validate.validateEmail(value),
                    onChange: (value) {
                      cubit.onChangeEmailAddress(value);
                    },
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  CustomFormField(
                    isPassword: true,
                    validate: (value) => Validate.validatePassword(value),
                    onChange: (value) {
                      cubit.onChangePassword(value);
                    },
                    hintText: "Password",
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PasswordBulletPoints(
                      title: Validate.getBulletPoints()[index],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: height(8),
                    ),
                    itemCount: Validate.getBulletPoints().length,
                  ),
                  SizedBox(
                    height: height(50),
                  ),
                  CustomButton(
                    showLoader: state is RegisterLoadingState,
                    fontSize: width(17),
                    function: () async {
                      if (_formKey.currentState!.validate()) {
                        cubit.registerUser();
                      }
                    },
                    text: "Sign Up",
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        fontSize: width(15),
                        text: "Already have an account?",
                        color: color.primaryColorDark.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: width(5),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          fontSize: width(15),
                          text: "Log In",
                          color: color.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
