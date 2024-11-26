import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'receipt.dart';

class TabletInventoryScreen extends StatefulWidget {
  const TabletInventoryScreen({super.key});

  @override
  _TabletInventoryScreenState createState() => _TabletInventoryScreenState();
}

class _TabletInventoryScreenState extends State<TabletInventoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedTab =
      'Product'; // To switch between Product and Category views
  String selectedCategoryFilter = 'All Categories';
  String searchQuery = ''; // Search query for filtering products and categories
  String _selectedSortOption = 'Name'; // Default sorting option

  List<String> categories = [
    'All Categories',
    'Category 1',
    'Category 2',
    'Category 3'
  ];

  List<Category> allCategories = List.generate(
    5,
    (index) => Category(
      name: 'Category $index',
      description: 'Description of Category $index',
      productCount: 20 + index,
    ),
  );

  List<Product> allProducts = List.generate(
    20,
    (index) => Product(
      name: 'Product $index',
      category: 'Category ${index % 3}',
      price: 10.0 + index,
      stock: 50 - index,
      location: 'Aisle ${index % 5}',
      dateImported: DateTime(2024, 1, 1),
      expiryDate: DateTime(2025, 1, 1),
    ),
  );

  List<Product> getFilteredProducts() {
    List<Product> filteredProducts = allProducts;

    if (selectedCategoryFilter != 'All Categories') {
      filteredProducts = filteredProducts
          .where((product) => product.category == selectedCategoryFilter)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filteredProducts;
  }

  List<Product> getSortedProducts() {
    List<Product> sortedProducts = getFilteredProducts();

    if (_selectedSortOption == 'Price') {
      sortedProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_selectedSortOption == 'Stock') {
      sortedProducts.sort((a, b) => a.stock.compareTo(b.stock));
    } else if (_selectedSortOption == 'Name') {
      sortedProducts.sort((a, b) => a.name.compareTo(b.name));
    }

    return sortedProducts;
  }

  List<Category> getFilteredCategories() {
    return allCategories.where((category) {
      return category.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          category.description
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('Admin Menu',
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("POS"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/pos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text("Sales"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/sales');
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Inventory"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/inventory');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Sidebar for Product and Category buttons
          Container(
            width: 180.0,
            color: Colors.blueAccent.withOpacity(0.1),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.inventory),
                  title: Text(
                    "Product",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selectedTab == 'Product'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedTab = 'Product';
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selectedTab == 'Category'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedTab = 'Category';
                    });
                  },
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: selectedTab == 'Product'
                  ? _buildProductList()
                  : _buildCategoryList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    List<Product> products = getSortedProducts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
              ),
            ),
            const SizedBox(width: 16.0),
            DropdownButton<String>(
              value: _selectedSortOption,
              onChanged: (value) {
                setState(() {
                  _selectedSortOption = value!;
                });
              },
              items: ['Name', 'Price', 'Stock']
                  .map((option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                color: index.isEven ? Colors.white : Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(product.name)),
                    Expanded(flex: 2, child: Text(product.category)),
                    Expanded(
                        flex: 1,
                        child: Text('\$${product.price.toStringAsFixed(2)}')),
                    Expanded(
                        flex: 2,
                        child: Text(
                            '${product.dateImported.toLocal().toString().split(' ')[0]}')),
                    Expanded(
                        flex: 2,
                        child: Text(
                            '${product.expiryDate.toLocal().toString().split(' ')[0]}')),
                    Expanded(flex: 1, child: Text('${product.stock}')),
                    Expanded(flex: 2, child: Text(product.location)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    List<Category> categories = getFilteredCategories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search categories...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          onChanged: (query) {
            setState(() {
              searchQuery = query;
            });
          },
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.description),
                  trailing: Text('${category.productCount} Products'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final String category;
  final double price;
  final int stock;
  final String location;
  final DateTime dateImported;
  final DateTime expiryDate;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.location,
    required this.dateImported,
    required this.expiryDate,
  });
}

class Category {
  final String name;
  final String description;
  final int productCount;

  Category({
    required this.name,
    required this.description,
    required this.productCount,
  });
}
