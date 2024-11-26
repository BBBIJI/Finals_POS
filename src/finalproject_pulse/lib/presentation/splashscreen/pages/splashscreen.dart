// ignore_for_file: use_build_context_synchronously

import 'package:finalproject_pulse/presentation/auth/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/presentation/splashscreen/bloc/splash_cubit.dart';
import 'package:finalproject_pulse/presentation/splashscreen/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE4E2C5),
        body: Center(
          child: Image.asset(
            'assets/Images/logogreen_tablet.PNG',
            fit: BoxFit.contain,
            width: screenwidth * 0.5,
            height: screenheight * 0.5,
          ),
        ),
      ),
    );
  }
}
