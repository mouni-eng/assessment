import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/infrastructure/alert_dialog.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/states.dart';
import 'package:mohamed_mounir_assesment/views/auth-views/logIn_view.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/search_view.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/widgets/finished_widget.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/widgets/repositry_widget.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_formField.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_navigation.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
          if (state is GetRepositriesError) {
            AlertService.showSnackbarAlert(
              "Something Went Wrong, Try again later",
              SnackbarType.error,
              context,
            );
          }
        }, builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.repositries.isNotEmpty,
              fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              builder: (context) {
                return Padding(
                  padding: padding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            fontSize: width(18),
                            text: "Flutter Assesment",
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout_rounded,
                              size: width(25),
                            ),
                            onPressed: () {
                              AuthCubit.get(context).logOut();
                              navigateReplacment(
                                view: LoginView(),
                                context: context,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(20),
                      ),
                      CustomSearchForm(
                        hintText: "Search repositories...",
                        onSubmit: (value) {
                          if (value.isNotEmpty) {
                            cubit.clearSearch();
                            cubit.searchRepositry(query: value);
                            navigateTo(
                              view: SearchView(query: value),
                              context: context,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: height(20),
                      ),
                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent &&
                              notification is ScrollUpdateNotification) {
                            cubit.getRepositries();
                          }
                          return true;
                        },
                        child: Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(15),
                            ),
                            itemBuilder: (context, index) {
                              if (index < cubit.repositries.length) {
                                return RepositryWidget(
                                    repository: cubit.repositries[index]);
                              } else {
                                return state is GetRepositriesFull
                                    ? const NoMoreWidget()
                                    : const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 30),
                                        child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                      );
                              }
                            },
                            itemCount: cubit.repositries.length + 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
