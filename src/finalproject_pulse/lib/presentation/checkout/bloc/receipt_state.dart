abstract class ReceiptState {}

class ReceiptInitial extends ReceiptState {}

class ReceiptLoaded extends ReceiptState {
  final List<Map<String, dynamic>> receipts;

  ReceiptLoaded(this.receipts);
}
