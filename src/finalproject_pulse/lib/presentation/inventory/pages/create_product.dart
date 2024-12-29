import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiredDateController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _stockController =
      TextEditingController(); // Added stock controller

  final _formKey = GlobalKey<FormState>();
  String? _category;
  String? _location = "Shelved"; // Default location
  int? _soldBy = 1;

  // Pick a date for expiry
  void _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        _expiredDateController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // Save the product data
  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final String todayDate = DateTime.now().toIso8601String().split('T')[0];

      // Get the current largest product_id from the in-memory list
      final int maxId = _getMaxProductId();

      // Calculate the new product_id
      final int newProductId = maxId + 1;

      // Create the Product object
      final product = Product(
        product_id: newProductId,
        name: _nameController.text,
        category: _category ?? 'Unknown',
        price: double.parse(_priceController.text),
        expiredDate: _expiredDateController.text,
        barcode: _barcodeController.text,
        soldBy: 'Each', // You can change this based on your logic
        unit: _unitController.text,
        stock: int.parse(_stockController.text), // Using the stock controller
        location: _location ?? 'Shelved', // Using the location dropdown value
        dateImported: todayDate, // Automatically set to today's date
      );

      // Add the product to InventoryBloc
      context.read<InventoryBloc>().add(AddProduct(product));

      // Navigate back after saving
      Navigator.pop(context);
    }
  }

  int _getMaxProductId() {
    // Replace `loadedProducts` with your actual List<Product> variable name
    final state = context.read<InventoryBloc>().state;

    if (state is InventoryLoaded) {
      final products = state.products;

      if (products.isEmpty) {
        return 0; // Return 0 if the list is empty
      }

      return products
          .map((products) => products.product_id)
          .reduce((a, b) => a > b ? a : b);
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 30),
                ),
                const Text(
                  'Create Product',
                  style: TextStyle(
                    color: AppColors.primarygreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                TextButton(
                  onPressed: _saveProduct,
                  child: const Text(
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
            const SizedBox(height: 20),
            // Form for product creation
            Form(
              key: _formKey,
              child: BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  List<String> categories = [];
                  if (state is InventoryLoaded) {
                    categories = state.categories.map((e) => e.name).toList();
                  }

                  return Container(
                    width: 600,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter a name'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                          ),
                          items: categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _category = value),
                          validator: (value) =>
                              value == null ? 'Select a category' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _expiredDateController,
                          decoration: InputDecoration(
                            labelText: 'Expired Date',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: _pickDate,
                            ),
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _barcodeController,
                          decoration: InputDecoration(
                            labelText: 'Barcode Number',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                            border: const UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _priceController,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  labelStyle:
                                      TextStyle(color: AppColors.primarygreen),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter a price'
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                controller: _unitController,
                                decoration: InputDecoration(
                                  labelText: 'Unit',
                                  labelStyle:
                                      TextStyle(color: AppColors.primarygreen),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter a unit'
                                        : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // New Stock field
                        TextFormField(
                          controller: _stockController,
                          decoration: InputDecoration(
                            labelText: 'Stock',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter stock'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        // Location dropdown
                        DropdownButtonFormField<String>(
                          value: _location,
                          items: const [
                            DropdownMenuItem(
                                value: 'Shelved', child: Text('Shelved')),
                            DropdownMenuItem(
                                value: 'Warehouse', child: Text('Warehouse')),
                          ],
                          onChanged: (value) =>
                              setState(() => _location = value),
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle:
                                TextStyle(color: AppColors.primarygreen),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Sold by',
                                style: TextStyle(
                                    color: AppColors.primarygreen,
                                    fontSize: 16)),
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _soldBy,
                                  onChanged: (value) =>
                                      setState(() => _soldBy = value as int),
                                ),
                                const Text('Each'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _soldBy,
                                  onChanged: (value) =>
                                      setState(() => _soldBy = value as int),
                                ),
                                const Text('Weight'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
