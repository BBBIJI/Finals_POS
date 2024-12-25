import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/data/model/category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Abstract base class for inventory events
abstract class InventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to add a category
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

// New Events
class FetchDataSuccess extends InventoryEvent {
  final List<Product> products;

  FetchDataSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class FetchDataError extends InventoryEvent {
  final String message;

  FetchDataError(this.message);

  @override
  List<Object?> get props => [message];
}

// Abstract base class for inventory states
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

// Bloc class for managing inventory
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
      final productIndex = _products
          .indexWhere((product) => product.barcode == event.product.barcode);

      if (productIndex != -1) {
        _products[productIndex] = event.product;
        emit(InventoryLoaded(categories: _categories, products: _products));
      }
    });

    on<FetchData>((event, emit) async {
      emit(InventoryLoading()); // Emit loading state

      try {
        // Fetch products from the API
        List products = await getProducts();

        // Parse products into `Product` objects
        final productList = products.map((p) => Product.fromJson(p)).toList();

        // Dispatch success event with fetched products
        add(FetchDataSuccess(productList));
      } catch (error) {
        // Dispatch error event with error message
        add(FetchDataError('Failed to fetch products: $error'));
      }
    });

    on<FetchDataSuccess>((event, emit) {
      _products.clear();
      _products.addAll(event.products);
      emit(InventoryLoaded(categories: _categories, products: _products));
    });

    on<FetchDataError>((event, emit) {
      emit(InventoryError(event.message));
    });
  }

  Future<List> getCategories() async {
    String url = "http://localhost/flutter/api/getAllCategories.php";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var category = jsonDecode(response.body);
      return category;
    } else {
      return [];
    }
  }

  Future<List> getProducts() async {
    String url = "http://localhost/flutter/api/getAllProducts.php";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var products = jsonDecode(response.body);
      return products;
    } else {
      return [];
    }
  }
}
