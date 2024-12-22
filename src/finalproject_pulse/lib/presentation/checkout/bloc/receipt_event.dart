abstract class ReceiptEvent {}

class AddReceiptEvent extends ReceiptEvent {
  final Map<String, dynamic> receipt;

  AddReceiptEvent(this.receipt);
}

class ClearReceiptsEvent extends ReceiptEvent {}
