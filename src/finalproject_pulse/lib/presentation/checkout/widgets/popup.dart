import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_event.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:finalproject_pulse/presentation/checkout/pages/receipt.dart'; // Ensure Receipt page is imported

class PaymentDialog extends StatelessWidget {
  final bool isCash;
  final double totalAmount;
  final Map<String, dynamic> cartItems;
  final String orderNumber;
  final double change;

  const PaymentDialog({
    Key? key,
    required this.isCash,
    required this.totalAmount,
    required this.cartItems,
    required this.orderNumber,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final String formattedTime = DateFormat('hh:mm a').format(now);

    return AlertDialog(
      backgroundColor: AppColors.primarygreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
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
              '$totalAmount NTD',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (isCash)
              Text(
                'Change: \$${change.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenlight,
              ),
              onPressed: () {
                // Create the receipt map
                Map<String, dynamic> receipt = {
                  'orderNumber': orderNumber,
                  'date': formattedDate,
                  'time': formattedTime,
                  'cartItems': cartItems,
                  'totalAmount': totalAmount,
                  'cashReceived': isCash ? totalAmount : 0,
                  'change': isCash ? change : 0,
                };

                // Add the receipt to the ReceiptBloc
                BlocProvider.of<ReceiptBloc>(context)
                    .add(AddReceiptEvent(receipt));

                // Navigate to the Receipt page with receipt data
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
