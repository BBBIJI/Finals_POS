import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_product.dart';

import 'package:flutter/material.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/navigationbar.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/category.dart'; // Import InventoryCategory for navigation
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';

class InventoryProduct extends StatelessWidget {
  const InventoryProduct({super.key});

  // Navigation logic for SideNavigationRail
  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Already on the InventoryProduct page, no action needed
        break;
      case 1:
        AppNavigator.pushReplacement(context, const InventoryCategory());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar widget
      drawer: CustomDrawer(), // Custom drawer for navigation
      body: Row(
        children: [
          // Side navigation menu for inventory sections
          SideNavigationRail(
            selectedIndex:
                0, // Currently selected index for the navigation rail
            onDestinationSelected: (int index) {
              _onDestinationSelected(context, index);
            },
          ),
          // Main content area for inventory management
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                    left: BorderSide(color: Colors.grey, width: 1),
                    right: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    // Title Row with dropdown filter and search bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title and Category Dropdown
                        Row(
                          children: [
                            // Title text "All Products"
                            Text(
                              'All Products',
                              style: TextStyle(
                                fontSize: 30,
                                color: AppColors.primarygreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            // Dropdown menu for selecting product categories
                            DropdownButton<String>(
                              hint: Text('Select Category'),
                              items: <String>[
                                'All Categories',
                                'Fruits',
                                'Vegetables',
                                'Dairy',
                                'Snacks',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle category filter change
                              },
                            ),
                          ],
                        ),
                        // Search Bar
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
                    SizedBox(height: 20), // Space between title and table
                    // Product list or "No products available" message
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Placeholder message for no products
                            if (true) // Replace with a condition checking for product existence
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'No products available. Please add products to see them here.',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              )
                            else
                              // Data table showing product information
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Category')),
                                  DataColumn(label: Text('Price')),
                                  DataColumn(label: Text('Date Imported')),
                                  DataColumn(label: Text('Stock')),
                                  DataColumn(label: Text('Location')),
                                ],
                                rows: [], // No rows initially
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Upload and Scanner Icons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Upload button
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.upload_file),
                                iconSize: 50,
                                onPressed: () {
                                  // Handle upload action
                                },
                              ),
                              Text('Upload', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(width: 20),
                          // Scanner button
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.photo_camera),
                                iconSize: 50,
                                onPressed: () {
                                  // Handle scanner action
                                },
                              ),
                              Text('Scanner', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, size: 50),
                                onPressed: () {
                                  AppNavigator.pushReplacement(
                                      context, const CreateProduct());
                                },
                              ),
                              Text('Add Item', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
