import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});

  // Convert a Category to a Map object for storage (SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon.codePoint, // store the icon's codePoint
    };
  }

  // Create a Category from a Map (for reading from storage)
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  // Factory method to create a Product from a JSON object
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['description'], icon: Icons.apple);
  }
  // Method to convert a Product to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon.codePoint,
    };
  }
}
