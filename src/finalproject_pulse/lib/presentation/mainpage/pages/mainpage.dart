import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/presentation/checkout/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/cartsumarry.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/product_card.dart'; // Import ProductCard
import 'package:finalproject_pulse/presentation/mainpage/widget/category_box.dart'; // Import CategoryBox

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Map<String, CartItem> _cartItems = {};
  double get _totalPrice => _cartItems.values
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Function to handle navigation to the checkout page
  void _goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Checkout(
          cartItems: _cartItems,
          totalPrice: _totalPrice,
          onReceiptAdded: _onReceiptAdded, // Callback to handle receipt
        ),
      ),
    );
  }

  // Callback function to handle the receipt after checkout
  void _onReceiptAdded(Map<String, dynamic> receipt) {
    // Handle receipt logic here (store in history, display, etc.)
    print('Receipt Added: $receipt');
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
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // Display the products using the ProductCard widget
                Expanded(
                  flex: 4,
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
                          itemCount:
                              state.products.length, // Display all products
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onAddToCart: () {
                                // Add the product to the cart
                                setState(() {
                                  if (_cartItems.containsKey(product.barcode)) {
                                    // Increment quantity if the product is already in the cart
                                    _cartItems[product.barcode]?.quantity++;
                                  } else {
                                    // Add the product to the cart with initial quantity 1
                                    _cartItems[product.barcode] = CartItem(
                                      barcode: product.barcode,
                                      productName: product.name,
                                      price: product.price,
                                      quantity: 1,
                                    );
                                  }
                                });
                              },
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
                // Categories (Assume categories are loaded here)
                Expanded(
                  flex: 1,
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
          // Cart Summary Section
          Expanded(
            flex: 2,
            child: CartSummary(
              cartItems: _cartItems,
              totalPrice: _totalPrice,
              clearCart: () {
                setState(() {
                  _cartItems.clear();
                });
              },
              onCheckout: _goToCheckout, // Passing checkout navigation function
            ),
          ),
        ],
      ),
    );
  }
}
