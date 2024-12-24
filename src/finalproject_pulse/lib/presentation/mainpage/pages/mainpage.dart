import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/data/model/cart_item_mode.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/pages/checkout_page.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/cartsumarry.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/product_card.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/category_box.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Map<String, CartItem> _cartItems = {};

  double get _totalPrice => _cartItems.values
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  void _handleBarcodeScanned(String barcode) {
    final state = context.read<InventoryBloc>().state;

    if (state is InventoryLoaded) {
      final product = state.products.firstWhere(
        (p) => p.barcode == barcode,
        orElse: () => Product(
          name: '',
          category: '',
          price: 0.0,
          expiredDate: '',
          barcode: '',
          soldBy: '',
          unit: '',
          stock: 0,
          location: '',
          dateImported: '',
        ),
      );

      setState(() {
        if (product.barcode.isNotEmpty) {
          if (_cartItems.containsKey(product.barcode)) {
            _cartItems[product.barcode]!.quantity++;
          } else {
            _cartItems[product.barcode] = CartItem(
              barcode: product.barcode,
              productName: product.name,
              price: product.price,
              quantity: 1,
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.name} added to cart!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text('Unrecognized barcode.')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: Appbarmain(
        onBarcodeScanned: _handleBarcodeScanned,
      ),
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
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onAddToCart: () {
                                setState(() {
                                  if (_cartItems.containsKey(product.barcode)) {
                                    _cartItems[product.barcode]?.quantity++;
                                  } else {
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
              onCheckout: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(
                      cartItems: _cartItems,
                      totalPrice: _totalPrice,
                      onReceiptAdded: (receipt) {
                        print('Receipt Added: $receipt');
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
