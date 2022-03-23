import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_product/modules/authentication/bloc/auth_bloc.dart';
import 'package:search_product/modules/home/bloc/product_bloc.dart';
import 'package:search_product/modules/home/pages/home_page.dart';
import 'package:search_product/modules/login/pages/login_page.dart';
import 'package:search_product/modules/splash.dart';

import 'shared/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      return runApp(MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc()..add(CheckAuth()),
          ),
          BlocProvider(
            create: (context) => ProductBloc(),
          ),
        ],
        child: MyApp(),
      ));
    },
    blocObserver: CustomBlocObserver()
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool initialized = false;
  @override
  void initState() {
    _startSplash();
    super.initState();
  }

  void _startSplash() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocSelector<AuthBloc, AuthState, bool>(
        selector: (state) {
          return state.isLogined;
        },
        builder: (context, state) {
          if (!initialized) return SplashPage();
          if (state) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
