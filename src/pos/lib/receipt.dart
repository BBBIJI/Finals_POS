import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'inventory.dart';


class ReceiptScreen extends StatefulWidget {
  final List<Receipt> receipts;

  const ReceiptScreen({Key? key, required this.receipts}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  String _selectedSortOption = 'Date';

  @override
  Widget build(BuildContext context) {
    List<Receipt> sortedReceipts = [...widget.receipts];

    // Sort receipts based on the selected option
    if (_selectedSortOption == 'Date') {
      sortedReceipts.sort((a, b) => b.date.compareTo(a.date));
    } else if (_selectedSortOption == 'Amount') {
      sortedReceipts.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(), // Opens the drawer
          ),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text(
                  'Admin Menu',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("POS"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/pos');
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text("Sales"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/sales');
                },
              ),
              ListTile(
                leading: const Icon(Icons.inventory),
                title: const Text("Inventory"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/inventory');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receipts',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                  items: ['Date', 'Amount']
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: sortedReceipts.isEmpty
                ? const Center(
                    child: Text(
                      'No receipts available.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: sortedReceipts.length,
                    itemBuilder: (context, index) {
                      final receipt = sortedReceipts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Amount: \$${receipt.totalAmount.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Payment Method: ${receipt.paymentMethod}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Date: ${receipt.date.toLocal().toString().split(' ')[0]}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              if (receipt.paymentMethod == 'Card' &&
                                  receipt.cardHolderName != null)
                                Text(
                                  'Cardholder Name: ${receipt.cardHolderName}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Receipt {
  final double totalAmount;
  final String paymentMethod;
  final String? cardHolderName;
  final DateTime date;

  Receipt({
    required this.totalAmount,
    required this.paymentMethod,
    this.cardHolderName,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}
