import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject_pulse/common/widgets/app_bar.dart';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';

class Checkoutpage extends StatelessWidget {
  const Checkoutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenlight,
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          VerticalDivider(
            width: 4, // Adjust the width of the divider
            color: Colors.grey, // Color of the divider
            thickness: 0.7, // Thickness of the divider line
            indent: 10, // Space above the divider
            endIndent: 10, // Space below the divider
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: 650,
                  height: 550,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      left: BorderSide(color: Colors.grey, width: 1),
                      right: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Total amount due',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'NT',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 250,
                                  height: 65,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Cash',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )),
                            GestureDetector(
                              onTap: () {
                                // Action for selecting Card
                              },
                              child: Container(
                                width: 250,
                                height: 65,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    'Card',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
