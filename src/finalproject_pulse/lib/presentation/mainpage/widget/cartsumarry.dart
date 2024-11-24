import 'package:flutter/material.dart';

class CartItem {
  final String productName;
  final double price;
  final int quantity;

  CartItem(
      {required this.productName, required this.price, required this.quantity});
}

class CartSummary extends StatelessWidget {
  final Map<String, CartItem> cartItems;
  final double totalPrice;
  final VoidCallback clearCart;

  const CartSummary({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
    required this.clearCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      color: Colors.grey[200],
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cart Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: clearCart,
                child: const Text('Clear Cart',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          const Divider(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              // Implement checkout functionality if needed here
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.green,
            ),
            child: const Center(child: Text('Checkout')),
          ),
        ],
      ),
    );
  }
}
