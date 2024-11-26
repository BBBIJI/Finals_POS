import 'package:flutter/material.dart';
import 'package:pos/dashboard.dart'; // Ensure the file exists
import 'package:pos/inventory.dart'; // Ensure the file exists
import 'package:pos/receipt.dart';
// Ensure the file exists

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Receipt> _receipts = []; // List to hold receipts

  void _addReceiptToList(Receipt newReceipt) {
    setState(() {
      _receipts.add(newReceipt); // Add the new receipt to the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS System',
      initialRoute: '/pos',
      routes: {
        '/pos': (context) => TabletPosScreen(
            onReceiptAdded: _addReceiptToList), // Pass the addReceipt function
        '/inventory': (context) => const TabletInventoryScreen(),
        '/sales': (context) => ReceiptScreen(receipts: _receipts),
        // Pass the list of receipts
      },
    );
  }
}
