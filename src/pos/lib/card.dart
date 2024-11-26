import 'package:flutter/material.dart';
import 'receipt.dart';

class CardPaymentScreen extends StatefulWidget {
  final double totalAmount;
  final Function(Receipt) onReceiptAdded;

  const CardPaymentScreen({
    super.key,
    required this.totalAmount,
    required this.onReceiptAdded,
  });

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

 String? _validateCardNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Card number cannot be empty.';
  }
  if (value.length != 16 || int.tryParse(value) == null) {
    return 'Invalid card number. Must be 16 digits.';
  }
  return null; // Return null if validation passes
}


 

  void _confirmPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      Receipt newReceipt = Receipt(
        totalAmount: widget.totalAmount,
        paymentMethod: 'Card',
        cardHolderName: cardHolderController.text,
      );

      widget.onReceiptAdded(newReceipt);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Successful'),
            content: const Text('Your payment has been processed successfully.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/sales');
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
             TextFormField(
  controller: cardNumberController,
  decoration: const InputDecoration(labelText: 'Card Number'),
  keyboardType: TextInputType.number,
  validator: _validateCardNumber, // Now compatible
),

              TextFormField(
                controller: cardHolderController,
                decoration: const InputDecoration(labelText: 'Cardholder Name'),
              ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmPayment,
                child: const Text('Confirm Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
