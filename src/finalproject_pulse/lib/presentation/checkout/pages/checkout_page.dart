import 'package:flutter/material.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/presentation/checkout/widgets/popup.dart'; // Use PaymentDialog
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';

class Checkout extends StatefulWidget {
  final Map<String, CartItem> cartItems;
  final double totalPrice;
  final Function onReceiptAdded;

  const Checkout({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
    required this.onReceiptAdded, // Callback to pass receipt
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isCashSelected = false;
  bool isCardSelected = false;
  TextEditingController _paymentController = TextEditingController();
  int _orderNumber = 1; // Start order numbers from #001

  String _generateOrderNumber() {
    return '#${_orderNumber.toString().padLeft(3, '0')}'; // Format as #001, #002, etc.
  }

  // Process Cash Payment
  void _processCashPayment(BuildContext context) {
    double cashProvided = double.tryParse(_paymentController.text) ?? 0;
    if (cashProvided < widget.totalPrice) {
      // Show error: Not enough cash
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough cash provided')),
      );
      return;
    } else {
      double change = cashProvided - widget.totalPrice;

      // Generate dynamic date and time
      DateTime now = DateTime.now();
      String date = now.toLocal().toString().split(' ')[0]; // Current date
      String time =
          "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}"; // Current time

      // Create a Receipt for cash payment
      String orderNumber = _generateOrderNumber();
      Map<String, dynamic> receipt = {
        'orderNumber': orderNumber,
        'date': date, // Current date
        'time': time, // Exact current time
        'cartItems': widget.cartItems,
        'totalAmount': widget.totalPrice,
        'cashReceived': cashProvided,
        'change': change,
      };

      // Show pop-up dialog with change
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PaymentDialog(
            isCash: true,
            totalAmount: widget.totalPrice,
            cartItems: widget.cartItems,
            orderNumber: orderNumber,
            change: change,
          );
        },
      );

      // Increment order number for next receipt
      setState(() {
        _orderNumber++;
      });
    }
  }

  // Process Card Payment
  void _processCardPayment(BuildContext context) {
    String cardNumber = _paymentController.text;
    if (cardNumber.length != 16) {
      // Show error: Invalid card number
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid card number')),
      );
      return;
    }

    // Generate dynamic date and time
    DateTime now = DateTime.now();
    String date = now.toLocal().toString().split(' ')[0]; // Current date
    String time =
        "${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}"; // Current time

    // Create a Receipt for card payment
    String orderNumber = _generateOrderNumber();
    Map<String, dynamic> receipt = {
      'orderNumber': orderNumber,
      'date': date, // Current date
      'time': time, // Exact current time
      'cartItems': widget.cartItems,
      'totalAmount': widget.totalPrice,
      'cashReceived': 0,
      'change': 0,
    };

    widget.onReceiptAdded(receipt); // Passing the receipt to history

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentDialog(
          isCash: false,
          totalAmount: widget.totalPrice,
          cartItems: widget.cartItems,
          orderNumber: orderNumber,
          change: 0, // No change for card payments
        );
      },
    );

    // Increment order number for next receipt
    setState(() {
      _orderNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          // Left Panel (Cart Summary)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total: ',
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
          const VerticalDivider(width: 4, color: Colors.grey, thickness: 0.7),
          // Right Panel (Payment and Checkout)
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCashSelected = true;
                                isCardSelected = false;
                                _paymentController.clear();
                              });
                            },
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCardSelected = true;
                                isCashSelected = false;
                                _paymentController.clear();
                              });
                            },
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 450,
                          height: 40,
                          margin: const EdgeInsets.only(left: 60),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                          child: TextField(
                            controller: _paymentController,
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
                            maxLength: isCardSelected ? 19 : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: 310,
                        height: 55,
                        child: CustomButton(
                          text: "Checkout",
                          onPressed: () {
                            if (isCashSelected) {
                              _processCashPayment(context);
                            } else if (isCardSelected) {
                              _processCardPayment(context);
                            }
                          },
                        ),
                      ),
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
