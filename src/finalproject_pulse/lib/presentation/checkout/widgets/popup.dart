import 'package:flutter/material.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/presentation/checkout/pages/receipt.dart';

class PaymentDialog extends StatelessWidget {
  final bool isCash; // Payment method
  final double totalAmount; // Total amount
  final double? receivedAmount; // Received amount for cash payments
  final double? change; // Change for cash payments
  final Map<String, CartItem> cartItems; // Cart items
  final Function(Map<String, dynamic>)
      onSaveReceipt; // Callback to save receipt
  final String orderNumber; // Order number

  const PaymentDialog({
    Key? key,
    required this.isCash,
    required this.totalAmount,
    this.receivedAmount,
    this.change,
    required this.cartItems,
    required this.onSaveReceipt,
    required this.orderNumber, // Add orderNumber as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primarygreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment Details',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Amount Received:',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              '${receivedAmount?.toStringAsFixed(2) ?? totalAmount.toStringAsFixed(2)} NTD',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isCash && change != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Change:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                '${change!.toStringAsFixed(2)} NTD',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenlight,
              ),
              onPressed: () {
                // Generate a receipt with the order number
                final receipt = {
                  'orderNumber': orderNumber, // Use the passed orderNumber
                  'cartItems': cartItems,
                  'totalAmount': totalAmount,
                  'cashReceived': receivedAmount,
                  'change': change,
                  'date': DateFormat('yyyy/MM/dd').format(DateTime.now()),
                  'time': DateFormat('hh:mm a').format(DateTime.now()),
                };

                // Save receipt via callback
                onSaveReceipt(receipt);

                // Navigate to Receipt page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Receipt(receipt: receipt),
                  ),
                );
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: AppColors.primarygreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
