// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // navigate to login page with delay 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/roleselection');
    });
    return Scaffold(
      backgroundColor: const Color(0xFFE4E2C5),
      body: Center(
        child: Image.asset(
          'assets/Images/logogreen_tablet.PNG',
          fit: BoxFit.contain,
          width: 500,
          height: 500,
        ),
      ),
    );
  }
}
