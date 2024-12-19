import 'package:flutter/material.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';

class Receipt extends StatefulWidget {
  final Map<String, dynamic> receipt; // Receive the new receipt

  const Receipt({Key? key, required this.receipt}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  List<Map<String, dynamic>> receiptHistory = []; // Local receipt history

  @override
  void initState() {
    super.initState();
    receiptHistory.add(widget.receipt); // Add the new receipt to history
  }

  Map<String, dynamic>? selectedReceipt; // Selected receipt for details
  String searchQuery = ''; // Search query for filtering receipts

  // Filter receipts by order number or employee name
  List<Map<String, dynamic>> get filteredReceipts {
    return receiptHistory.where((receipt) {
      final orderNumber = receipt['orderNumber'].toString().toLowerCase();
      final employee = receipt['employee'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return orderNumber.contains(query) || employee.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          // Left Panel (Receipt History)
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Receipts',
                    style: TextStyle(
                      color: AppColors.primarygreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Search Bar and Filter
                  Row(
                    children: [
                      Icon(Icons.search, color: AppColors.primarygreen),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search by Order Number or Employee',
                            hintStyle: TextStyle(color: AppColors.primarygreen),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  Expanded(
                    child: ListView(
                      children: filteredReceipts.map((receipt) {
                        return ListTile(
                          title: Text(receipt['orderNumber']),
                          subtitle:
                              Text('${receipt['date']} - ${receipt['time']}'),
                          trailing: Text(
                              '\$${receipt['totalAmount'].toStringAsFixed(2)}'),
                          onTap: () {
                            setState(() {
                              selectedReceipt =
                                  receipt; // Update selected receipt
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider and Right Panel (Receipt Details)
          const VerticalDivider(
              width: 4,
              color: Colors.grey,
              thickness: 0.7,
              indent: 10,
              endIndent: 10),
          Expanded(
            flex: 2,
            child: Center(
              child: selectedReceipt != null
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 4,
                        ),
                      ),
                      width: 436,
                      height: 622,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.all(3)),
                          Image.asset('assets/images/IconGreen.png',
                              width: 81, height: 89),
                          const Divider(color: Colors.grey, thickness: 2),
                          Text('RECEIPT',
                              style: TextStyle(
                                  color: AppColors.primarygreen,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold)),
                          const Divider(color: Colors.grey, thickness: 2),
                          const SizedBox(height: 16),
                          Text(selectedReceipt!['orderNumber'],
                              style: TextStyle(
                                  color: AppColors.primarygreen,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Text('Date: ${selectedReceipt!['date']}',
                              style: TextStyle(
                                  color: AppColors.primarygreen, fontSize: 18)),
                          Text('Time: ${selectedReceipt!['time']}',
                              style: TextStyle(
                                  color: AppColors.primarygreen, fontSize: 18)),
                          const Divider(color: Colors.grey, thickness: 2),
                          Expanded(
                            child: ListView(
                              children: selectedReceipt!['cartItems']
                                  .values
                                  .map<Widget>((CartItem item) {
                                return ListTile(
                                  title: Text(item.productName),
                                  subtitle: Text('Quantity: ${item.quantity}'),
                                  trailing: Text(
                                      '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                                );
                              }).toList(),
                            ),
                          ),
                          const Divider(color: Colors.grey, thickness: 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTotalRow('Subtotal:',
                                  '\$${selectedReceipt!['totalAmount'].toStringAsFixed(2)}'),
                              _buildTotalRow('Cash:',
                                  '\$${selectedReceipt!['cashReceived'].toStringAsFixed(2)}'),
                              _buildTotalRow('Change:',
                                  '\$${selectedReceipt!['change'].toStringAsFixed(2)}'),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const Center(child: Text('No receipt selected')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: AppColors.primarygreen, fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                  color: AppColors.primarygreen, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
