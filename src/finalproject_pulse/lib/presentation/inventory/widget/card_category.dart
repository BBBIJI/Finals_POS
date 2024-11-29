import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.icon,
    required this.name,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        elevation: 2, // Slight shadow for depth
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFECE6D8), // Light beige background
            border: Border.all(
              color: Colors.grey.shade300, // Subtle border color
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.green.shade800, // Match theme color
              ),
              const SizedBox(height: 8), // Space between icon and text
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800, // Match theme color
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
