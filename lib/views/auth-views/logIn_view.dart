import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/infrastructure/alert_dialog.dart';
import 'package:mohamed_mounir_assesment/infrastructure/utils.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/states.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/signup_view.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/widgets/custom_divider.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/widgets/social_card.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/home_view.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_button.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_formField.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_navigation.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    SizeConfig().init(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is LogInErrorState) {
        AlertService.showSnackbarAlert(
            "Email or Password is incorrect!", SnackbarType.error, context);
      } else if (state is LogInSuccessState) {
        navigateTo(
          view: const HomeView(),
          context: context,
        );
      }
    }, builder: (context, state) {
      AuthCubit cubit = AuthCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Center(
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
                      height: height(20),
                    ),
                    CustomText(
                      fontSize: width(20),
                      text: "Welcome Back",
                      color: color.primaryColor,
                    ),
                    SizedBox(
                      height: height(50),
                    ),
                    CustomFormField(
                      validate: (value) => Validate.validateEmail(value),
                      onChange: (value) {
                        cubit.onChangeEmailAddress(value);
                      },
                      hintText: "Email",
                    ),
                    SizedBox(
                      height: height(20),
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
                      height: height(40),
                    ),
                    CustomButton(
                      showLoader: state is LogInLoadingState,
                      fontSize: width(17),
                      function: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.logIn();
                        }
                      },
                      text: "Sign in",
                    ),
                    SizedBox(
                      height: height(40),
                    ),
                    const CustomDivider(),
                    SizedBox(
                      height: height(27),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialCard(
                          logo: "assets/icons/Google.svg",
                          onTap: () async {
                            await cubit.loginWithGoogle();
                          },
                        ),
                        SizedBox(
                          width: width(27),
                        ),
                        SocialCard(
                          logo: "assets/icons/Facebook.svg",
                          onTap: () async {
                            await cubit.loginWithFacebook();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(38),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          fontSize: width(15),
                          text: "Dont have account?",
                          color: color.primaryColorDark.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: width(5),
                        ),
                        InkWell(
                          onTap: () {
                            navigateTo(
                              view: SignUpView(),
                              context: context,
                            );
                          },
                          child: CustomText(
                            fontSize: width(15),
                            text: "Sign Up",
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
          ),
        )),
      );
    });
  }
}
