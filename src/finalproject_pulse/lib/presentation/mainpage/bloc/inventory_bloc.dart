import 'package:flutter_bloc/flutter_bloc.dart';

// Models
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final int stock;
  final String unit; // e.g., 'kg', 'piece', etc.

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.stock,
    required this.unit,
  });
}

// Events
abstract class InventoryEvent {}

class TabSelected extends InventoryEvent {
  final String selectedTab;
  TabSelected({required this.selectedTab});
}

class SearchProducts extends InventoryEvent {
  final String query;
  SearchProducts({required this.query});
}

class FilterByCategory extends InventoryEvent {
  final String category;
  FilterByCategory({required this.category});
}

class AddProduct extends InventoryEvent {
  final Product product;
  AddProduct({required this.product});
}

class UpdateProduct extends InventoryEvent {
  final Product product;
  UpdateProduct({required this.product});
}

class DeleteProduct extends InventoryEvent {
  final String productId;
  DeleteProduct({required this.productId});
}

// States
abstract class InventoryState {}

class ProductTabSelected extends InventoryState {
  final List<Product> products;
  final String? currentCategory;
  final String? searchQuery;

  ProductTabSelected({
    required this.products,
    this.currentCategory,
    this.searchQuery,
  });
}

class CategoryTabSelected extends InventoryState {
  final List<String> categories;
  CategoryTabSelected({required this.categories});
}

class LoadingState extends InventoryState {}

class ErrorState extends InventoryState {
  final String message;
  ErrorState({required this.message});
}

// Bloc
class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List<Product> _allProducts = [];
  String? _currentCategory;
  String? _searchQuery;

  InventoryBloc() : super(LoadingState()) {
    _initializeProducts();

    on<TabSelected>((event, emit) {
      if (event.selectedTab == 'Product') {
        emit(ProductTabSelected(
          products: _filterProducts(),
          currentCategory: _currentCategory,
          searchQuery: _searchQuery,
        ));
      } else if (event.selectedTab == 'Category') {
        emit(CategoryTabSelected(categories: _getCategories()));
      }
    });

    on<SearchProducts>((event, emit) {
      _searchQuery = event.query;
      emit(ProductTabSelected(
        products: _filterProducts(),
        currentCategory: _currentCategory,
        searchQuery: _searchQuery,
      ));
    });

    on<FilterByCategory>((event, emit) {
      _currentCategory = event.category;
      emit(ProductTabSelected(
        products: _filterProducts(),
        currentCategory: _currentCategory,
        searchQuery: _searchQuery,
      ));
    });

    on<AddProduct>((event, emit) {
      _allProducts.add(event.product);
      emit(ProductTabSelected(
        products: _filterProducts(),
        currentCategory: _currentCategory,
        searchQuery: _searchQuery,
      ));
    });

    on<UpdateProduct>((event, emit) {
      final index = _allProducts.indexWhere((p) => p.id == event.product.id);
      if (index != -1) {
        _allProducts[index] = event.product;
        emit(ProductTabSelected(
          products: _filterProducts(),
          currentCategory: _currentCategory,
          searchQuery: _searchQuery,
        ));
      }
    });

    on<DeleteProduct>((event, emit) {
      _allProducts.removeWhere((p) => p.id == event.productId);
      emit(ProductTabSelected(
        products: _filterProducts(),
        currentCategory: _currentCategory,
        searchQuery: _searchQuery,
      ));
    });
  }

  void _initializeProducts() {
    // Sample data - replace with actual data source
    _allProducts = [
      Product(
        id: '1',
        name: 'Korean Muscat Grapes',
        price: 125.0,
        category: 'Fruits & Vegetables',
        imageUrl: 'assets/images/grapes.png',
        stock: 200,
        unit: 'g',
      ),
      // Add more sample products...
    ];
  }

  List<String> _getCategories() {
    return [
      'Fruits & Vegetables',
      'Dairy Products',
      'Meat',
      'Beverages',
      'Snacks',
    ];
  }

  List<Product> _filterProducts() {
    List<Product> filteredProducts = List.from(_allProducts);

    if (_currentCategory != null) {
      filteredProducts = filteredProducts
          .where((product) => product.category == _currentCategory)
          .toList();
    }

    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) =>
              product.name.toLowerCase().contains(_searchQuery!.toLowerCase()))
          .toList();
    }

    return filteredProducts;
  }
}
