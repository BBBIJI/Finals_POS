import 'package:flutter_bloc/flutter_bloc.dart';
import 'receipt_event.dart';
import 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final List<Map<String, dynamic>> _receipts = [];
  int _receiptNumber = 1; // Start receipt numbers from 001

  ReceiptBloc() : super(ReceiptInitial()) {
    // Handle adding a new receipt
    on<AddReceiptEvent>((event, emit) {
      // Generate a receipt number (e.g., #001, #002, etc.)
      String receiptNumber = '#${_receiptNumber.toString().padLeft(3, '0')}';

      // Increment receipt number for the next receipt
      _receiptNumber++;

      // Add timestamp for date and time
      DateTime now = DateTime.now();
      String date = now.toLocal().toString().split(' ')[0]; // Date: YYYY-MM-DD
      String time = now.toLocal().toString().split(' ')[1]; // Time: HH:mm:ss

      // Construct receipt with generated details
      Map<String, dynamic> receipt = {
        'orderNumber': receiptNumber,
        'date': date,
        'time': time,
        'cartItems': event.receipt['cartItems'],
        'totalAmount': event.receipt['totalAmount'],
        'cashReceived': event.receipt['cashReceived'],
        'change': event.receipt['change'],
      };

      _receipts.add(receipt);
      emit(ReceiptLoaded(List.from(_receipts))); // Emit updated receipts
    });

    // Handle clearing all receipts
    on<ClearReceiptsEvent>((event, emit) {
      _receipts.clear();
      emit(ReceiptLoaded(List.from(_receipts))); // Emit an empty receipts list
    });
  }

  // Method to retrieve the current list of receipts
  List<Map<String, dynamic>> get receipts => List.unmodifiable(_receipts);
}
