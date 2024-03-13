import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mounir_assesment/constants.dart';
import 'package:mohamed_mounir_assesment/infrastructure/cache_helper.dart';
import 'package:mohamed_mounir_assesment/view-models/app_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/app_cubit/states.dart';
import 'package:mohamed_mounir_assesment/view-models/auth_cubit/cubit.dart';
import 'package:mohamed_mounir_assesment/view-models/home_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..getRepositries()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => AppCubit()..getUser()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return MaterialApp(
              title: 'Flutter Assesment',
              theme: lightTheme,
              debugShowCheckedModeBanner: false,
              home: ConditionalBuilder(
                  condition: state is! GetUserDataLoadingState,
                  builder: (context) => cubit.currentView(),
                  fallback: (context) => const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )),
            );
          }),
    );
  }
}
