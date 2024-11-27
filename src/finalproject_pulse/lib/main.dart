import 'package:finalproject_pulse/presentation/splashscreen/pages/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/presentation/splashscreen/bloc/splash_cubit.dart';

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
