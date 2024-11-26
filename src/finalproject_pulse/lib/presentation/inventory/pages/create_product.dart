import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/common/widgets/custom_button.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  int? _soldBy =
      1; // Variable to keep track of the "sold by" selection (Each or Weight)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar for the page
      drawer: CustomDrawer(), // Custom drawer for side navigation
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Row containing back button, title, and save button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {}, // Handle back button press
                  icon: Icon(Icons.arrow_back),
                  iconSize: 50,
                ),
                Text(
                  'Create Product',
                  style: TextStyle(
                    color: AppColors.primarygreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                TextButton(
                  onPressed: () {}, // Handle save button press
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
            SizedBox(height: 20), // Space between header and form
            // Main Container for Product Form
            Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 30), // Space before Product Image section
                      // Product Image Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Placeholder for Product Image
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                              width: 20), // Space between image and buttons
                          Column(
                            children: [
                              // Button to Select Photo
                              CustomButton(
                                text: 'Select Photo',
                                onPressed: () {}, // Handle selecting photo
                                color: AppColors.primarygreen,
                                width: 160.0,
                                height: 50.0,
                                borderRadius: 8.0,
                              ),
                              SizedBox(height: 10), // Space between buttons
                              // Button to Take Photo
                              CustomButton(
                                text: 'Take Photo',
                                onPressed: () {}, // Handle taking photo
                                color: AppColors.primarygreen,
                                width: 160.0,
                                height: 50.0,
                                borderRadius: 8.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30), // Space before product details form
                      // Product Name Input Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Product name',
                          labelStyle: TextStyle(color: AppColors.primarygreen),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20), // Space between input fields
                      // Product Category Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: AppColors.primarygreen),
                        ),
                        items: ['Category 1', 'Category 2', 'Category 3']
                            .map((String category) => DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // Handle category selection change
                        },
                      ),
                      SizedBox(height: 20), // Space between input fields
                      // SKU and Barcode Input Fields
                      Row(
                        children: [
                          // SKU Input Field
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'SKU',
                                labelStyle:
                                    TextStyle(color: AppColors.primarygreen),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                              width:
                                  20), // Space between SKU and Barcode fields
                          // Barcode Input Field
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Barcode number',
                                labelStyle:
                                    TextStyle(color: AppColors.primarygreen),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Space before "Sold By" section
                      // Sold By Section
                      Row(
                        children: [
                          // Sold By Label
                          Text(
                            'Sold by',
                            style: TextStyle(
                              color: AppColors.primarygreen,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                              width: 20), // Space between label and options
                          // Sold By Options - Each and Weight
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: _soldBy,
                                  onChanged: (value) =>
                                      setState(() => _soldBy = value as int)),
                              Text('Each'), // Option: Sold by Each
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: _soldBy,
                                  onChanged: (value) =>
                                      setState(() => _soldBy = value as int)),
                              Text('Weight'), // Option: Sold by Weight
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Space between input fields
                      // Price and Unit Input Fields
                      Row(
                        children: [
                          // Price Input Field
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Price',
                                labelStyle:
                                    TextStyle(color: AppColors.primarygreen),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 20), // Space between Price and Unit fields
                          // Unit Input Field
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Unit',
                                labelStyle:
                                    TextStyle(color: AppColors.primarygreen),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
