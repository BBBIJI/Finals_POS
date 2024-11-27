// ignore_for_file: prefer_const_constructors
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  // List of available icons for category selection
  final List<IconData> categoryIcons = [
    Icons.apple,
    Icons.egg,
    Icons.grain,
    Icons.local_florist,
    Icons.rice_bowl,
    Icons.icecream,
    Icons.cookie,
    Icons.local_cafe,
    Icons.cake,
    Icons.set_meal,
    Icons.local_dining,
    Icons.no_meals,
    Icons.soup_kitchen,
    Icons.breakfast_dining,
    Icons.dinner_dining,
    Icons.bakery_dining,
  ];

  int? selectedIconIndex; // Stores the index of the selected icon

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar widget for consistency
      drawer: CustomDrawer(), // Custom drawer for side navigation
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                IconButton(
                  onPressed: () {
                    AppNavigator.pushReplacement(context, InventoryCategory());
                  }, // Define back button action here
                  icon: Icon(Icons.arrow_back),
                  iconSize: 50,
                ),
                // Title "Create Category"
                Text(
                  'Create Category',
                  style: TextStyle(
                    color: AppColors.primarygreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                // Save Button
                TextButton(
                  onPressed: () {}, // Define save button action here
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: AppColors.primarygreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 50), // Space between header and category icon label

            // Category Icon Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Category icon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primarygreen,
                ),
              ),
            ),
            SizedBox(height: 20), // Space before category icons grid

            // Category Icons Selection Container
            Container(
              width: screenWidth * 0.9,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primarygreen.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                // GridView for displaying icons
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // Number of icons per row
                    crossAxisSpacing: 5, // Spacing between icons
                    mainAxisSpacing: 5, // Spacing between rows
                  ),
                  itemCount: categoryIcons.length, // Total number of icons
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Set the selected icon index
                        setState(() {
                          selectedIconIndex = index;
                        });
                      },
                      child: Icon(
                        categoryIcons[index],
                        color: selectedIconIndex == index
                            ? AppColors.primarygreen
                            : AppColors.primarygreen.withOpacity(0.5),
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30), // Space before the category name input field

            // Category Name Input Field
            SizedBox(
              width: screenWidth * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Category Name',
                  hintStyle: TextStyle(
                    color: AppColors.primarygreen,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(69, 158, 158, 158),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30), // Space before the action buttons

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Assign Products Button
                CustomButton(
                  text: "Assign Products",
                  onPressed: () {
                    // Define action for "Assign Products"
                  },
                  width: screenWidth * 0.35,
                  height: 50,
                  borderRadius: 8,
                ),
                // Create Products Button
                CustomButton(
                  text: "Create Products",
                  onPressed: () {
                    // Define action for "Create Products"
                  },
                  width: screenWidth * 0.35,
                  height: 50,
                  borderRadius: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
