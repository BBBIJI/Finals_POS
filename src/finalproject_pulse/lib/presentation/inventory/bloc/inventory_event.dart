import 'package:equatable/equatable.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';

// Abstract base class for inventory events
abstract class InventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to add a product
class AddProduct extends InventoryEvent {
  final Product product;

  AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}
