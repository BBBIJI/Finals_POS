// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/navigationbar.dart';

class InventoryCategory extends StatelessWidget {
  const InventoryCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar for consistency across screens
      drawer: CustomDrawer(), // Custom drawer for side navigation
      body: Row(
        children: [
          // Side navigation rail for navigating between inventory pages
          SideNavigationRail(
            selectedIndex: 0, // Currently selected index in the navigation rail
            onDestinationSelected: (int index) {
              // Handle navigation changes here based on the selected index
            },
          ),
          // Main content area for displaying inventory categories
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
                    // Header Row with Title and Search Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page Title
                        Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.primarygreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Search Bar for searching categories
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
                    SizedBox(height: 20), // Space between title and grid

                    // Grid View for Category Cards
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3, // Number of columns in the grid
                        crossAxisSpacing: 20, // Space between grid columns
                        mainAxisSpacing: 20, // Space between grid rows
                        padding: EdgeInsets.all(10.0),
                        childAspectRatio:
                            0.8, // Aspect ratio to adjust card size
                        children: List.generate(12, (index) {
                          return Card(
                            elevation: 2, // Shadow elevation for card
                            child: Container(
                              width: 100, // Fixed width for smaller size
                              height: 100, // Fixed height for smaller size
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon representing the category
                                  Icon(Icons.cottage,
                                      size: 50), // Smaller icon size
                                  SizedBox(
                                      height:
                                          10), // Space between icon and text
                                  // Category name
                                  Text(
                                    'Dairy Products', // Replace with the dynamic category name
                                    style: TextStyle(
                                        fontSize: 16), // Smaller text size
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Row for Add Category Icon/Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Icon Button for adding a new category
                          IconButton(
                            icon: Icon(Icons.add, size: 50),
                            onPressed: () {
                              // Handle add action to create a new category
                            },
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
