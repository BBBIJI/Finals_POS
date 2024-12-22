import 'package:finalproject_pulse/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';

class CartSummary extends StatelessWidget {
  final Map<String, CartItem> cartItems;
  final double totalPrice;
  final VoidCallback clearCart;
  final VoidCallback onCheckout; // Checkout callback passed from MainPage

  const CartSummary({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
    required this.clearCart,
    required this.onCheckout, // Callback passed to handle checkout navigation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cart Summary Title and Clear Cart Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cart Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: clearCart,
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
            children: cartItems.values.map((item) {
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // Checkout Button
        SizedBox(
          width: double.infinity, // Make the button span full width
          height: 50,
          child: CustomButton(
            text: "Checkout",
            onPressed: onCheckout, // Trigger checkout navigation
          ),
        ),
      ],
    );
  }
}
