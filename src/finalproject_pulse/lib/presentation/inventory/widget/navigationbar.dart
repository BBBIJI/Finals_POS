import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SideNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const SideNavigationRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: AppColors.primarygreen,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      minWidth: 120, // Adjust the width of the rail
      labelType: NavigationRailLabelType.none, // Hide labels for now
      indicatorColor:
          Colors.transparent, // Remove the default selection indicator
      destinations: const [
        NavigationRailDestination(
          icon: Padding(
            padding:
                EdgeInsets.only(top: 16.0), // Add padding at top for spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.food_bank,
                  color: Colors.white,
                  size: 40, // Increase the icon size
                ),
                SizedBox(height: 8), // Space between icon and text
                Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Adjust font size
                  ),
                ),
              ],
            ),
          ),
          label: Text(''), // Empty label, required by NavigationRailDestination
        ),
        NavigationRailDestination(
          icon: Padding(
            padding:
                EdgeInsets.only(top: 16.0), // Add padding at top for spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.category,
                  color: Colors.white,
                  size: 40, // Increase the icon size
                ),
                SizedBox(height: 8), // Space between icon and text
                Text(
                  'Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Adjust font size
                  ),
                ),
              ],
            ),
          ),
          label: Text(''), // Empty label, required by NavigationRailDestination
        ),
        // Add more destinations as needed
      ],
    );
  }
}
