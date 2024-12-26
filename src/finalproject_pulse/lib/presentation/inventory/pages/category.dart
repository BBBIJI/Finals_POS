import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/create_category.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/navigationbar.dart';
import 'package:finalproject_pulse/presentation/inventory/widget/card_category.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:finalproject_pulse/data/model/category_model.dart';

class InventoryCategory extends StatefulWidget {
  const InventoryCategory({super.key});

  @override
  State<InventoryCategory> createState() => _InventoryCategoryState();
}

class _InventoryCategoryState extends State<InventoryCategory> {
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchAndDispatchCategory();
  }

  Future<void> _fetchAndDispatchCategory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List categoryList = await getCategories();
      final List<Category> categories =
          categoryList.map((c) => Category.fromJson(c)).toList();
      context.read<InventoryBloc>().add(FetchCategorySuccess(categories));
    } catch (error) {
      context
          .read<InventoryBloc>()
          .add(FetchDataError('Failed to fetch categories123: $error'));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List> getCategories() async {
    String url = "http://localhost/flutter/api/getAllCategories.php";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var products = jsonDecode(response.body);
      return products;
    } else {
      throw Exception('Failed to load categories');
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
            selectedIndex: 1,
            onDestinationSelected: (index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InventoryProduct()),
                );
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.primarygreen,
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
                  Expanded(
                    child: BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                        if (_isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is InventoryLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is InventoryLoaded) {
                          final categories = state.categories;

                          if (categories.isEmpty) {
                            return const Center(
                                child: Text('No categories available.'));
                          }

                          return GridView.count(
                            crossAxisCount: 5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            padding: const EdgeInsets.all(10.0),
                            children: categories.map((category) {
                              return CategoryCard(
                                icon: category.icon,
                                name: category.name,
                                onTap: () {
                                  print('Tapped on ${category.name}');
                                },
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(
                              child: Text('no categories added'));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add, size: 50),
                          onPressed: () {
                            AppNavigator.push(context, const CreateCategory());
                          },
                        ),
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
