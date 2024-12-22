import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_state.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';

class Receipt extends StatelessWidget {
  final Map<String, dynamic>? receipt; // Single receipt details

  const Receipt({Key? key, this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: receipt != null
          ? _buildReceiptDetails(
              context, receipt!) // Display single receipt details
          : _buildReceiptHistory(context), // Display receipt history
    );
  }

  // Build Receipt Details View
  Widget _buildReceiptDetails(
      BuildContext context, Map<String, dynamic> receiptData) {
    return Row(
      children: [
        // Left Panel (Receipt Details)
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receipt Details',
                  style: TextStyle(
                    color: AppColors.primarygreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey, thickness: 1),
                ListTile(
                  title: Text(receiptData['orderNumber'] ?? 'Unknown'),
                  subtitle: Text(
                      'Date: ${receiptData['date']} - Time: ${receiptData['time']}'),
                  trailing: Text('\$${receiptData['totalAmount']}'),
                ),
                const Divider(color: Colors.grey, thickness: 1),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 4, color: Colors.grey, thickness: 0.7),
        // Right Panel (Receipt Content)
        Expanded(
          flex: 2,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 4),
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
                  Text(
                    'RECEIPT',
                    style: TextStyle(
                        color: AppColors.primarygreen,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.grey, thickness: 2),
                  const SizedBox(height: 16),
                  Text(
                    receiptData['orderNumber'] ?? 'Unknown',
                    style: TextStyle(
                        color: AppColors.primarygreen,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Date: ${receiptData['date']}',
                    style:
                        TextStyle(color: AppColors.primarygreen, fontSize: 18),
                  ),
                  Text(
                    'Time: ${receiptData['time']}',
                    style:
                        TextStyle(color: AppColors.primarygreen, fontSize: 18),
                  ),
                  const Divider(color: Colors.grey, thickness: 2),
                  Expanded(
                    child: ListView(
                      children: receiptData['cartItems']
                              ?.values
                              .map<Widget>((CartItem item) {
                            return ListTile(
                              title: Text(item.productName),
                              subtitle: Text('Quantity: ${item.quantity}'),
                              trailing: Text(
                                  '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                  const Divider(color: Colors.grey, thickness: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTotalRow(
                          'Subtotal:', '\$${receiptData['totalAmount']}'),
                      _buildTotalRow(
                          'Cash:', '\$${receiptData['cashReceived']}'),
                      _buildTotalRow('Change:', '\$${receiptData['change']}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build Receipt History View
  Widget _buildReceiptHistory(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded && state.receipts.isNotEmpty) {
          final receipts = state.receipts;
          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final singleReceipt = receipts[index];
              return ListTile(
                title: Text(singleReceipt['orderNumber']),
                subtitle: Text(
                    'Date: ${singleReceipt['date']} - Time: ${singleReceipt['time']}'),
                trailing: Text('\$${singleReceipt['totalAmount']}'),
                onTap: () {
                  // Navigate to the details of the selected receipt
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Receipt(receipt: singleReceipt),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'No receipts available.',
              style: TextStyle(
                color: AppColors.primarygreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
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
