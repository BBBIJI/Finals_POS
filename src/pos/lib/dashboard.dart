import 'package:flutter/material.dart';
import 'inventory.dart';
import 'card.dart';
import 'cash.dart';
import 'receipt.dart';

class TabletPosScreen extends StatefulWidget {
  final Function(Receipt) onReceiptAdded; // Callback for adding receipts

  const TabletPosScreen({super.key, required this.onReceiptAdded});

  @override
  _TabletPosScreenState createState() => _TabletPosScreenState();
}

class _TabletPosScreenState extends State<TabletPosScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, CartItem> _cartItems = {};
  double _totalPrice = 0.0;

  List<Product> allProducts = List.generate(
    12,
    (index) => Product(
      name: 'Product $index',
      price: 10.99 + index,
      category: 'Category ${index % 3}',
      imageUrl: 'assets/product_image.png',
    ),
  );

  List<String> categories = ['All', 'Category 0', 'Category 1', 'Category 2'];
  String selectedCategory = 'All';

  void _addToCart(String productName, double price) {
    setState(() {
      if (_cartItems.containsKey(productName)) {
        _cartItems[productName]!.quantity++;
      } else {
        _cartItems[productName] = CartItem(
          productName: productName,
          price: price,
          quantity: 1,
        );
      }
      _totalPrice += price;
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
      _totalPrice = 0.0;
    });
  }

  List<Product> getFilteredProducts() {
    if (selectedCategory == 'All') {
      return allProducts;
    }
    return allProducts
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('POS System'),
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
                Navigator.pushReplacementNamed(context, '/test');
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Product Grid Section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Product Grid Inside a Container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: getFilteredProducts().length,
                      itemBuilder: (context, index) {
                        final product = getFilteredProducts()[index];
                        return ProductCard(
                          productName: product.name,
                          price: product.price,
                          onAddToCart: () =>
                              _addToCart(product.name, product.price),
                        );
                      },
                    ),
                  ),
                  // Category List
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedCategory = selected ? category : 'All';
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Cart Summary Section
          Container(
            width: 300.0,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Summary Title and Clear Cart Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cart Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: _clearCart,
                      child: const Text(
                        'Clear Cart',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: _cartItems.values.map((item) {
                      return ListTile(
                        title: Text(item.productName),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: Text(
                            '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('\$${_totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8.0),

                ElevatedButton(
                  onPressed: () {
                    if (_cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Your cart is empty!')),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Choose Payment Method'),
                          actions: [
                            TextButton(
                              child: const Text('Cash'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CashPaymentScreen(
                                      totalAmount: _totalPrice,
                                      onReceiptAdded: (Receipt newReceipt) {
                                        widget.onReceiptAdded(newReceipt);
                                        _clearCart();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              child: const Text('Card'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CardPaymentScreen(
                                      totalAmount: _totalPrice,
                                      onReceiptAdded: (Receipt newReceipt) {
                                        widget.onReceiptAdded(newReceipt);
                                        _clearCart();
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: const Center(child: Text('Checkout')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double price;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/product_image.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(productName, style: const TextStyle(fontSize: 16)),
          Text('\$$price',
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ElevatedButton(
            onPressed: onAddToCart,
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String productName;
  final double price;
  int quantity;

  CartItem({
    required this.productName,
    required this.price,
    this.quantity = 1,
  });
}
