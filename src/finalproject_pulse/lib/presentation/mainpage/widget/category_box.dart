import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/presentation/inventory/bloc/inventory_bloc.dart';

class CategoryBox extends StatelessWidget {
  final String label;

  const CategoryBox({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.greenlight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        if (state is InventoryLoaded) {
          final categories = state.categories;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryBox(label: categories[index].name),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
