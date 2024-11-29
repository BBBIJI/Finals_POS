import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/navigationbar.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_product.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';

class InventoryProduct extends StatefulWidget {
  const InventoryProduct({super.key});

  @override
  State<InventoryProduct> createState() => _InventoryProductState();
}

class _InventoryProductState extends State<InventoryProduct> {
  // State to hold the list of products
  List<Product> products = [];

  // Method to simulate adding a product
  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void _onDestinationSelected(int index) {
    switch (index) {
      case 0: // Stay on InventoryProduct
        break;
      case 1: // Navigate to InventoryCategory
        AppNavigator.pushReplacement(context, const InventoryCategory());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          SideNavigationRail(
            selectedIndex: 0,
            onDestinationSelected: _onDestinationSelected,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'All Products',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            hint: const Text('Select Category'),
                            items: const [
                              'All Categories',
                              'Fruits',
                              'Vegetables',
                              'Dairy',
                              'Snacks',
                            ].map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Handle category selection
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
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
                  // Product Table or Empty State
                  if (products.isEmpty)
                    const Center(
                      child: Text(
                        'No products available. Please add products to see them here.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Category')),
                            DataColumn(label: Text('Price')),
                            DataColumn(label: Text('Expired Date')),
                            DataColumn(label: Text('Barcode')),
                            DataColumn(label: Text('Sold By')),
                            DataColumn(label: Text('Unit')),
                          ],
                          rows: products.map((product) {
                            return DataRow(
                              cells: [
                                DataCell(Text(product.name)),
                                DataCell(Text(product.category)),
                                DataCell(Text(product.price.toString())),
                                DataCell(Text(product.expiredDate)),
                                DataCell(Text(product.barcode)),
                                DataCell(Text(product.soldBy)),
                                DataCell(Text(product.unit)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  // Add Item Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, size: 50),
                          onPressed: () async {
                            // Navigate to CreateProduct and add a new product
                            final newProduct = await Navigator.push<Product>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CreateProduct(),
                              ),
                            );

                            if (newProduct != null) {
                              _addProduct(newProduct);
                            }
                          },
                        ),
                        const Text('Add Item'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
