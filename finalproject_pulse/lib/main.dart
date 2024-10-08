// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'app/presentation/splashscreen/splashscreen.dart';
import 'app/presentation/roleselection/roleselection_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse Pos and inventory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Splashscreen(),
        '/roleselection': (context) => const RoleSelection(),
      },
    );
  }
}
