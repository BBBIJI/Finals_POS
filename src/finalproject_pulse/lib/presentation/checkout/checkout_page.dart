import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';

class Checkout extends StatefulWidget {
  final Map<String, CartItem> cartItems;
  final double totalPrice;

  const Checkout(
      {super.key, required this.cartItems, required this.totalPrice});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isCashSelected = false;
  bool isCardSelected = false;
  TextEditingController _paymentController = TextEditingController();

  // Update the selected payment method
  void onButtonTapped(String button) {
    setState(() {
      if (button == 'cash') {
        isCashSelected = true;
        isCardSelected = false;
        _paymentController.clear(); // Clear the input when switching to cash
      } else if (button == 'card') {
        isCardSelected = true;
        isCashSelected = false;
        _paymentController.clear(); // Clear the input when switching to card
      }
    });
  }

  // Card validation logic for 16 digits
  void validateCardNumber(String value) {
    if (value.length != 16) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Card Number'),
          content: const Text('Card number must be exactly 16 digits.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: AppColors.greenlight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cart Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  // Display Cart Items List
                  Expanded(
                    child: ListView(
                      children: widget.cartItems.values.map((item) {
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
                        '\$${widget.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(
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
                      const Text(
                        'Total amount due',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${widget.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
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
                      // Conditional Input Field (Cash or Card)
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
                            controller:
                                _paymentController, // Use the controller
                            decoration: InputDecoration(
                              hintText: isCardSelected
                                  ? "Enter card number"
                                  : "Amount received",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: isCardSelected
                                ? 19
                                : null, // Set maxLength for card only
                            inputFormatters: isCardSelected
                                ? [
                                    FilteringTextInputFormatter
                                        .digitsOnly, // Only digits allowed
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                        final text = newValue.text.replaceAll(
                                            RegExp(r'\D'),
                                            ''); // Remove non-digits
                                        String formatted = '';
                                        for (int i = 0; i < text.length; i++) {
                                          if (i > 0 && i % 4 == 0) {
                                            formatted += '-';
                                          }
                                          formatted += text[i];
                                        }
                                        return newValue.copyWith(
                                          text: formatted,
                                        );
                                      },
                                    ),
                                  ]
                                : [
                                    FilteringTextInputFormatter.digitsOnly,
                                    TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                        final newText = newValue.text
                                            .replaceAll(
                                                RegExp(
                                                    r'(?<=\d)(?=(\d{3})+\b)'),
                                                ',');
                                        return newValue.copyWith(text: newText);
                                      },
                                    ),
                                  ],
                            onChanged: (value) {
                              if (isCardSelected) {
                                // Validate only if card number is entered
                                if (value.length == 16) {
                                  validateCardNumber(
                                      value); // Validate once 16 digits are entered
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Final Checkout Button
                      SizedBox(
                        width: 310,
                        height: 55,
                        child: CustomButton(
                          text: "Checkout",
                          onPressed: () {
                            // Implement your checkout logic here
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
