// Bottom Navigation Button Widget
import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final String label;

  const BottomNavButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 16), // Adjust padding
        backgroundColor: Colors.green[700], // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Rectangular shape
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16), // Optional text style
      ),
    );
  }
}
