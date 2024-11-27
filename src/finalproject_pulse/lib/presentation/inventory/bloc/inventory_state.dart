import 'package:equatable/equatable.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';

// Base class for inventory states
abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state when the app starts
class InventoryInitial extends InventoryState {}

// State for when data is being loaded
class InventoryLoading extends InventoryState {}

// State when products are successfully loaded
class InventoryLoaded extends InventoryState {
  final List<Product> products;

  InventoryLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

// State for when an error occurs
class InventoryError extends InventoryState {
  final String message;

  InventoryError(this.message);

  @override
  List<Object?> get props => [message];
}
