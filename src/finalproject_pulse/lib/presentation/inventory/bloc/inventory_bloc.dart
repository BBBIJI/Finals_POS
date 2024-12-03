import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/data/model/category_model.dart';

// Events
abstract class InventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCategory extends InventoryEvent {
  final Category category;
  AddCategory(this.category);
  @override
  List<Object?> get props => [category];
}

class AddProduct extends InventoryEvent {
  final Product product;
  AddProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class UpdateProductLocation extends InventoryEvent {
  final Product product;

  UpdateProductLocation(this.product);

  @override
  List<Object?> get props => [product];
}

class FetchData extends InventoryEvent {}

// States
abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<Category> categories;
  final List<Product> products;

  InventoryLoaded({required this.categories, required this.products});

  @override
  List<Object?> get props => [categories, products];
}

class InventoryError extends InventoryState {
  final String message;

  InventoryError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final List<Category> _categories = [];
  final List<Product> _products = [];

  InventoryBloc() : super(InventoryInitial()) {
    on<AddCategory>((event, emit) {
      _categories.add(event.category);
      emit(InventoryLoaded(categories: _categories, products: _products));
    });

    on<AddProduct>((event, emit) {
      _products.add(event.product);
      emit(InventoryLoaded(categories: _categories, products: _products));
    });

    on<UpdateProductLocation>((event, emit) {
      // Find the product and update its location
      final productIndex = _products
          .indexWhere((product) => product.barcode == event.product.barcode);
      if (productIndex != -1) {
        _products[productIndex] =
            event.product; // Update the product in the list
        emit(InventoryLoaded(
            categories: _categories,
            products: _products)); // Emit updated products
      }
    });

    on<FetchData>((event, emit) {
      emit(InventoryLoaded(categories: _categories, products: _products));
    });
  }
}
