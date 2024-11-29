// ignore_for_file: prefer_const_constructors

import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
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
    Icons.fastfood,
    Icons.pie_chart,
    Icons.restaurant,
    Icons.kitchen,
  ];

  int? selectedIconIndex;
  final TextEditingController _categoryNameController = TextEditingController();

  void _saveCategory() {
    if (selectedIconIndex == null || _categoryNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an icon and enter a name')),
      );
      return;
    }

    // Pass the selected category back to the calling page
    final newCategory = {
      'icon': categoryIcons[selectedIconIndex!],
      'name': _categoryNameController.text,
    };

    Navigator.pop(context, newCategory);
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
                  icon: Icon(Icons.arrow_back, size: 50),
                ),
                Text(
                  'Create Category',
                  style: TextStyle(
                    color: AppColors.primarygreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
                TextButton(
                  onPressed: _saveCategory,
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
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Category Icon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primarygreen,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Icon Selection Grid
            Container(
              height: 250,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: categoryIcons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
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
            SizedBox(height: 30),
            // Category Name Input
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: _categoryNameController,
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
          ],
        ),
      ),
    );
  }
}
