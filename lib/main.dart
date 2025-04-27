import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:foodies/auth/presentation/bloc/password/password_bloc.dart';
import 'package:foodies/auth/presentation/screens/SplashScreen.dart';
import 'package:foodies/canteen%20items/presentation/blocs/add_cart_bloc/add_cart_bloc.dart';
import 'package:foodies/canteen%20items/presentation/blocs/items_bloc/item_bloc.dart';
import 'package:foodies/canteen%20list/presentation/bloc/canteen_bloc.dart';
import 'package:foodies/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:foodies/checkout/presentation/blocs/bloc/summary_bloc.dart';
import 'package:foodies/razorpay/presentation/bloc/payment_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<PasswordBloc>(
          create: (BuildContext context) => PasswordBloc(),
        ),
        BlocProvider<CanteenBloc>(
          create: (BuildContext context) => CanteenBloc(),
        ),
        BlocProvider<ItemBloc>(
          create: (BuildContext context) => ItemBloc(),
        ),
        BlocProvider<AddCartBloc>(
          create: (BuildContext context) => AddCartBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) => CartBloc(),
        ),
        BlocProvider<SummaryBloc>(
          create: (BuildContext context) => SummaryBloc(),
        ),
        BlocProvider<PaymentBloc>(
          create: (BuildContext context) => PaymentBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Canteen Connect',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
