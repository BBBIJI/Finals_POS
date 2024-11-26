// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/appbar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/buttonnav.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  // Cart items map
  final Map<String, CartItem> _cartItems = {
    "1": CartItem(productName: "Product A", quantity: 2, price: 10.0),
    "2": CartItem(productName: "Product B", quantity: 1, price: 20.0),
  };

  // Getter to calculate the total price
  double get _totalPrice {
    return _cartItems.values
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Method to clear the cart
  void _clearCart() {
    setState(() {
      _cartItems.clear(); // Clear all cart items
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: Appbarmain(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Product list (flex 3)
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Fruits & Vegetables",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text("Product List Placeholder"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Bottom Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomNavButton(label: 'Fruits & Vegetables'),
                      BottomNavButton(label: 'Dairy Products'),
                      BottomNavButton(label: 'Bakery Items'),
                    ],
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 4, // Adjust the width of the divider
              color: Colors.grey, // Color of the divider
              thickness: 0.7, // Thickness of the divider line
            ),
            // Cart summary (flex 1)
            Expanded(
              flex: 1,
              child: Container(
                width: 300.0,
                color: AppColors.greenlight,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Summary Title and Clear Cart Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cart Summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: _clearCart,
                          child: const Text(
                            'Clear Cart',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Display Cart Items
                    Expanded(
                      child: ListView(
                        children: _cartItems.values.map((item) {
                          return ListTile(
                            title: Text(item.productName),
                            subtitle: Text('Quantity: ${item.quantity}'),
                            trailing: Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                          );
                        }).toList(),
                      ),
                    ),
                    const Divider(),
                    // Display Total Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${_totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Checkout Button
                    ElevatedButton(
                      onPressed: () {
                        // Implement checkout functionality
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                      ),
                      child: const Center(child: Text('Checkout')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CartItem Model
class CartItem {
  final String productName;
  final int quantity;
  final double price;

  CartItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

// Drawer Item Widget
class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const DrawerItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[900]),
      title: Text(label, style: TextStyle(color: Colors.black)),
      onTap: () {
        // Handle navigation
      },
    );
  }
}

// Bottom Navigation Button Widget
class BottomNavButton extends StatelessWidget {
  final String label;

  const BottomNavButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.green[700],
      ),
      child: Text(label),
    );
  }
}
