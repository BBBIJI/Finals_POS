import 'package:finalproject_pulse/presentation/mainpage/widget/cartsumarry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/product_card.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/category_box.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/presentation/checkout/pages/checkout_page.dart'; // Import Checkout page

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Map<String, CartItem> _cartItems = {};

  double get _totalPrice => _cartItems.values
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  void _addToCart(String productName, double price, int stock) {
    setState(() {
      if (_cartItems.containsKey(productName)) {
        if (_cartItems[productName]!.quantity + 1 > stock) {
          // Alert for exceeding stock
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Stock Limit Reached'),
              content: const Text(
                  'You cannot add more items than available in stock.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
        _cartItems[productName]!.quantity++;
      } else {
        _cartItems[productName] = CartItem(
          productName: productName,
          price: price,
          quantity: 1,
        );
      }
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  void _goToCheckout() {
    // Navigate to Checkout page with cart items and total price
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Checkout(
          cartItems: _cartItems, // Pass cart items
          totalPrice: _totalPrice, // Pass total price
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 5, // Increased flex for product section
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Fruits & Vegetables",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 4, // Adjusted flex for products
                  child: BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is InventoryLoaded) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onAddToCart: () => _addToCart(
                                product.name,
                                product.price,
                                product.stock,
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load products.'),
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1, // Adjusted flex for categories
                  child: BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryLoaded) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CategoryBox(label: category.name),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(
            width: 4,
            color: Colors.grey,
            thickness: 0.7,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            flex: 2,
            child: CartSummary(
              cartItems: _cartItems,
              totalPrice: _totalPrice,
              clearCart: _clearCart,
              onCheckout: _goToCheckout, // Added onCheckout callback
            ),
          ),
        ],
      ),
    );
  }
}
