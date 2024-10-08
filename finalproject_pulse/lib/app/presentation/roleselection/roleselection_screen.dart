// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4E2C5),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/Images/icongreen.PNG',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            Text(
              "Select Your Role",
              style: TextStyle(
                  color: const Color(0xFF0C301E),
                  fontSize: 48,
                  fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: const Color(0xFF0C301E),
                  height: 375,
                  width: 366,
                ),
                Container(
                  color: const Color(0xFF0C301E),
                  height: 375,
                  width: 366,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
