// lib/custom_widgets.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:finalproject_pulse/presentation/inventory/pages/product.dart';
import 'package:finalproject_pulse/presentation/mainpage/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';

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
          height: 60, // Adjust logo size as needed
          width: 60,
        ),
      ),
      centerTitle: true, // Ensures the logo is centered in AppBar
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, right: 12.0), // Padding for avatar
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/profile.png', // Replace with your profile image asset
            ),
            radius: 20, // Adjust CircleAvatar size as needed
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
        color: AppColors
            .primarygreen, // Matches the background color of the drawer
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
                      AppNavigator.pushReplacement(
                          context, Mainpage()); // Define navigation logic
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.inventory,
                    label: 'Inventory',
                    onTap: () {
                      AppNavigator.pushReplacement(context,
                          InventoryProduct()); // Define navigation logic
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.receipt,
                    label: 'Receipts',
                    onTap: () {
                      // Define navigation logic
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.report,
                    label: 'Staff Report',
                    onTap: () {
                      // Define navigation logic
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  16.0), // Adjust padding for the footer logo
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
