import 'package:flutter/material.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text; // The text that will be displayed on the button
  final Color color; // Background color of the button
  final VoidCallback
      onPressed; // The function that is called when the button is pressed
  final double? width; // Optional: Width of the button
  final double? height; // Optional: Height of the button
  final double borderRadius; // Border radius of the button

  // Constructor to pass parameters to the widget
  // ignore: use_super_parameters
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primarygreen, // Default background color
    this.width,
    this.height,
    this.borderRadius = 8.0, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use the customizable color parameter
        minimumSize: width != null && height != null
            ? Size(width!, height!)
            : null, // Dynamically adapt size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
