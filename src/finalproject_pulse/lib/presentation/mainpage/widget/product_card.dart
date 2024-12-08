import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.greenlight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 5),
            Text('\$${product.price.toStringAsFixed(2)}'),
            const SizedBox(height: 5),
            Text('Stock: ${product.stock}'),
          ],
        ),
      ),
    );
  }
}
