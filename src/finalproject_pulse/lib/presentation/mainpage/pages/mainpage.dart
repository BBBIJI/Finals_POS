import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/category_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/mainpage/widget/product_card.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Map<String, CartItem> _cartItems = {
    "1": CartItem(productName: "Product A", quantity: 2, price: 10.0),
    "2": CartItem(productName: "Product B", quantity: 1, price: 20.0),
  };

  double get _totalPrice {
    return _cartItems.values
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Fruits & Vegetables",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                        if (state is InventoryLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is InventoryLoaded) {
                          if (state.products.isEmpty) {
                            return const Center(
                                child: Text('No products available.'));
                          }
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
                              return ProductCard(product: product);
                            },
                          );
                        } else {
                          return const Center(child: Text('Failed to load.'));
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.greenlight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                        if (state is InventoryLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is InventoryLoaded) {
                          if (state.categories.isEmpty) {
                            return const Center(
                                child: Text('No categories available.'));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CategoryBox(
                                    label: state.categories[index].name),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('Failed to load.'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(
              width: 4,
              color: Colors.grey,
              thickness: 0.7,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 300.0,
                color: AppColors.greenlight,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cart Summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${_totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement checkout functionality
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
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String productName;
  final int quantity;
  final double price;

  CartItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}
