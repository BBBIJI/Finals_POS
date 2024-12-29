import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_product.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/navigationbar.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/category.dart';

class InventoryProduct extends StatefulWidget {
  const InventoryProduct({super.key});

  @override
  State<InventoryProduct> createState() => _InventoryProductState();
}

class _InventoryProductState extends State<InventoryProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          // Left Sidebar Navigation
          SideNavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (index) {
              if (index == 1) {
                // Navigate to Category page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InventoryCategory()),
                );
              }
            },
          ),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search or manual input...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // BlocBuilder listens to InventoryBloc state changes
                  BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is InventoryLoaded) {
                        final products = state.products;

                        if (products.isEmpty) {
                          return const Center(
                            child: Text(
                              'No products available. Please add products to see them here.',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          );
                        }

                        return Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('ID')),
                                  DataColumn(label: Text('Barcode')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Category')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Date Imported')),
                                  DataColumn(label: Text('Expiry Date')),
                                  DataColumn(label: Text('Stock')),
                                  DataColumn(label: Text('Location')),
                                ],
                                rows: products.map((product) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                          Text(product.product_id.toString())),
                                      DataCell(Text(product.barcode)),
                                      DataCell(Text(product.name)),
                                      DataCell(
                                          Text(product.category.toString())),
                                      DataCell(Text(product.price.toString())),
                                      DataCell(Text(product.dateImported)),
                                      DataCell(Text(product.expiredDate)),
                                      DataCell(Text(product.stock.toString())),
                                      DataCell(Text(product.location)),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      } else if (state is InventoryError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const Center(child: Text('No data available.'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
          onPressed: () async {
            // Open CreateProduct page when the user clicks 'Add Item'
            final newProduct = await Navigator.push<Product>(
              context,
              MaterialPageRoute(builder: (context) => const CreateProduct()),
            );

            if (newProduct != null) {
              // Add the new product to the InventoryBloc
              context.read<InventoryBloc>().add(AddProduct(newProduct));
            }
          },
          child: const Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
    );
  }
}
