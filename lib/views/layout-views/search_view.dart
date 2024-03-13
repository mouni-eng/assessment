import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/size_config.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/states.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/widgets/finished_widget.dart';
import 'package:mohamed_mounir_assesment/views/layout-views/widgets/repositry_widget.dart';
import 'package:mohamed_mounir_assesment/widgets/custom_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          fontSize: width(20),
          text: "Search for $query",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
          if (state is GetRepositriesError) {}
        }, builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.searchedRepositries.isNotEmpty,
              fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              builder: (context) {
                return Padding(
                  padding: padding,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent &&
                          notification is ScrollUpdateNotification) {
                        cubit.searchRepositry(query: query);
                      }
                      return true;
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        height: height(15),
                      ),
                      itemBuilder: (context, index) {
                        if (index < cubit.searchedRepositries.length) {
                          return RepositryWidget(
                              repository: cubit.searchedRepositries[index]);
                        } else {
                          return state is GetRepositriesFull
                              ? const NoMoreWidget()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                );
                        }
                      },
                      itemCount: cubit.searchedRepositries.length + 1,
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
