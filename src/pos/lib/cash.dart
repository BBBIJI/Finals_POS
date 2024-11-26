import 'package:flutter/material.dart';
import 'receipt.dart'; // Import the Receipt model

class CashPaymentScreen extends StatefulWidget {
  final double totalAmount;
  final Function(Receipt) onReceiptAdded; // Accept the callback

  const CashPaymentScreen({
    super.key,
    required this.totalAmount,
    required this.onReceiptAdded,
  });

  @override
  _CashPaymentScreenState createState() => _CashPaymentScreenState();
}

class _CashPaymentScreenState extends State<CashPaymentScreen> {
  final TextEditingController _cashController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _cashController
        .dispose(); // Dispose of the controller when no longer needed
    super.dispose();
  }

  void _processPayment() {
    double cashProvided = double.tryParse(_cashController.text) ?? 0;
    if (cashProvided < widget.totalAmount) {
      setState(() {
        _errorMessage = 'Not enough cash provided.';
      });
    } else {
      double change = cashProvided - widget.totalAmount;
      Receipt newReceipt = Receipt(
        totalAmount: widget.totalAmount,
        paymentMethod: 'Cash',
      );
      widget.onReceiptAdded(newReceipt);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Payment Successful'),
            content: Text('Change: \$${change.toStringAsFixed(2)}'),
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
        title: const Text('Cash Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cashController,
              decoration: const InputDecoration(labelText: 'Enter Cash Amount'),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _processPayment(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processPayment,
              child: const Text('Confirm Payment'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
