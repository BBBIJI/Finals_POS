import 'package:finalproject_pulse/presentation/inventory/pages/category.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_category.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_product.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/product.dart';
import 'package:finalproject_pulse/presentation/mainpage/pages/mainpage.dart';
import 'package:finalproject_pulse/presentation/splashscreen/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/presentation/splashscreen/bloc/splash_cubit.dart';
import 'package:finalproject_pulse/presentation/mainpage/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/profilepage/pages/profilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit()..appStarted(),
        ),
        BlocProvider(
          create: (context) => InventoryBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Pulse Pos and Inventory',
        debugShowCheckedModeBanner: false,
        // Home page
        home: const Splashscreen(),
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}
