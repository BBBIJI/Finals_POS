// lib/custom_widgets.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finalproject_pulse/presentation/checkout/pages/receipt.dart';
import 'package:finalproject_pulse/presentation/inventory/pages/product.dart';
import 'package:finalproject_pulse/presentation/mainpage/pages/mainpage.dart';
import 'package:finalproject_pulse/presentation/profilepage/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_bloc.dart';
import 'package:finalproject_pulse/presentation/checkout/bloc/receipt_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(80.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primarygreen,
      leading: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, left: 8.0, right: 8.0), // Padding for leading icon
        child: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 40, // Adjust icon size if needed
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 16.0, right: 16.0), // Padding for title
        child: Image.asset(
          'assets/images/IconWhite.png', // Replace with your logo image asset
          height: 60,
          width: 60,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 12.0),
          child: MaterialButton(
            onPressed: () {
              AppNavigator.pushReplacement(context, const Profilepage());
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: const Icon(
              Icons.camera_alt,
              size: 24,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primarygreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.shopping_cart,
                    label: 'POS',
                    onTap: () {
                      AppNavigator.push(context, Mainpage());
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.inventory,
                    label: 'Inventory',
                    onTap: () {
                      AppNavigator.push(context, InventoryProduct());
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt,
                    label: 'Receipts',
                    onTap: () {
                      AppNavigator.push(
                        context,
                        BlocBuilder<ReceiptBloc, ReceiptState>(
                          builder: (context, state) {
                            if (state is ReceiptLoaded &&
                                state.receipts.isNotEmpty) {
                              return Receipt(); // Show receipt history
                            } else {
                              return Scaffold(
                                appBar: AppBar(
                                  title: const Text('Receipts'),
                                  backgroundColor: AppColors.primarygreen,
                                ),
                                body: Center(
                                  child: const Text(
                                    'No receipts available.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.report,
                    label: 'Staff Report',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pulse POS System',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding:
            EdgeInsets.zero, // Remove the default padding for the tile
        onTap: onTap,
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 8.0), // Padding on top of the icon
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically centers the icon
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 30, // Adjust icon size
              ),
            ],
          ),
        ),
        title: Padding(
          padding:
              const EdgeInsets.only(top: 4.0), // Padding on top of the label
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically centers the text
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
