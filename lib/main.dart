import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/auth/presentation/bloc/password/password_bloc.dart';
import 'package:foodies/auth/presentation/screens/SplashScreen.dart';
import 'package:foodies/canteen%20list/presentation/bloc/canteen_bloc.dart';
import 'package:foodies/homepage/presentation/bloc/page_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<PasswordBloc>(create: (BuildContext context) => PasswordBloc()),
        BlocProvider<PageBloc>(
          create: (BuildContext context) => PageBloc(),
        ),
        BlocProvider<CanteenBloc>(
          create: (BuildContext context) => CanteenBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
