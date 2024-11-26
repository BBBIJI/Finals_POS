import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isCashSelected = false;
  bool isCardSelected = false;

  // Sample data for cart items
  Map<String, CartItem> _cartItems = {
    'item1': CartItem(productName: 'Product 1', quantity: 1, price: 10.0),
    'item2': CartItem(productName: 'Product 2', quantity: 2, price: 15.0),
  };

  // Calculate total price for all items in the cart
  double get _totalPrice {
    return _cartItems.values
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Clear the cart items
  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  // Update the selected payment method
  void onButtonTapped(String button) {
    setState(() {
      if (button == 'cash') {
        isCashSelected = !isCashSelected;
        isCardSelected = false;
      } else if (button == 'card') {
        isCardSelected = !isCardSelected;
        isCashSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar widget
      drawer: CustomDrawer(), // Custom drawer widget for navigation
      body: Row(
        children: [
          // Cart Summary Section
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
                      // Clear cart button to remove all items from the cart
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
                  // Display Cart Items List
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
                  // Display Total Price of Cart Items
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
          // Vertical Divider between Cart and Payment Sections
          VerticalDivider(
            width: 4,
            color: Colors.grey,
            thickness: 0.7,
            indent: 10,
            endIndent: 10,
          ),
          // Payment Section
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 650,
                  height: 550,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Total Amount Text
                      const Text(
                        'Total amount due',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'NT', // Currency or Amount representation (could be changed)
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      // Payment Method Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cash Payment Method Button
                          GestureDetector(
                            onTap: () => onButtonTapped('cash'),
                            child: Container(
                              width: 250,
                              height: 65,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: isCashSelected
                                    ? AppColors.primarygreen
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Cash',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: isCashSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Card Payment Method Button
                          GestureDetector(
                            onTap: () => onButtonTapped('card'),
                            child: Container(
                              width: 250,
                              height: 65,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: isCardSelected
                                    ? AppColors.primarygreen
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Card',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: isCardSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Card Number Input Field (visible only if card is selected)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 450,
                          height: 40,
                          margin: const EdgeInsets.only(left: 60),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter card number",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Final Checkout Button
                      CustomButton(
                        text: "Checkout",
                        color: Colors.white,
                        onPressed: () {
                          // Implement checkout functionality
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Define CartItem class if not already defined
class CartItem {
  final String productName; // Product name in the cart
  final int quantity; // Quantity of the product
  final double price; // Price of the product

  CartItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}
