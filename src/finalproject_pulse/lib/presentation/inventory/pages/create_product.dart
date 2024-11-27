import 'package:flutter/material.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';

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

  final _formKey = GlobalKey<FormState>();
  String? _category;
  int? _soldBy = 1;

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

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final String soldBy = _soldBy == 1 ? 'Each' : 'Weight';

      // Create a Product object from the entered data
      final product = Product(
        name: _nameController.text,
        category: _category ?? 'Unknown',
        expiredDate: _expiredDateController.text,
        barcode: _barcodeController.text,
        soldBy: soldBy,
        price: double.parse(_priceController.text),
        unit: _unitController.text,
      );

      // Pass the Product object back to the previous screen
      Navigator.pop(context, product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(), // Custom app bar for the page
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
              child: Container(
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
                        labelStyle: TextStyle(color: AppColors.primarygreen),
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
                        labelStyle: TextStyle(color: AppColors.primarygreen),
                      ),
                      items: ['Category 1', 'Category 2', 'Category 3']
                          .map((String category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) => setState(() => _category = value),
                      validator: (value) =>
                          value == null ? 'Select a category' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _expiredDateController,
                      decoration: InputDecoration(
                        labelText: 'Expired Date',
                        labelStyle: TextStyle(color: AppColors.primarygreen),
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
                        labelStyle: TextStyle(color: AppColors.primarygreen),
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
                            validator: (value) => value == null || value.isEmpty
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
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter a unit'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Sold by',
                            style: TextStyle(
                                color: AppColors.primarygreen, fontSize: 16)),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
