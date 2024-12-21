// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:finalproject_pulse/core/config/theme/app_colors.dart';
import 'package:finalproject_pulse/common/helpr/navigator/app_navigator.dart';
import 'package:finalproject_pulse/presentation/mainpage/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          // Left side of the screen - Green background with Logo
          Expanded(
            child: Container(
              color: AppColors.primarygreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the logo
                  Image.asset(
                    'assets/Images/logowhite.PNG',
                    height: screenheight * 0.3,
                    width: screenwidth * 0.45,
                  )
                ],
              ),
            ),
          ),
          // Right side of the screen - Login form
          Expanded(
            child: Container(
              color: AppColors.primarygreen,
              child: Center(
                child: Container(
                  height: screenheight * 0.9,
                  width: screenwidth * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.greenlight,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 40, 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Spacer
                        const SizedBox(height: 50),

                        // Welcome text
                        const Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primarygreen,
                          ),
                        ),
                        const Text(
                          'please enter your details to login your account',
                          style: TextStyle(
                            color: AppColors.primarygreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        // Spacer before the form fields
                        const SizedBox(height: 80),

                        // Username textfield with label
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Username',
                              style: TextStyle(
                                color: AppColors.primarygreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0x260C301E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Spacer before the next input
                        const SizedBox(height: 20),

                        // Password textfield with label and 'Forgot password?' text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Color(0xFF0c301e),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0x260C301E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true, // Hide password characters
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Spacer before the login button
                        const SizedBox(height: 80),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primarygreen,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Log In ',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          _msg,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    String url = "http://localhost/flutter/api/login.php";

    final Map<String, dynamic> queryParams = {
      "username": _usernameController.text,
      "password": _passwordController.text
    };

    try {
      http.Response response =
          await http.get(Uri.parse(url).replace(queryParameters: queryParams));

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body); //return type list<Map>
        if (user.isNotEmpty) {
          setState(() {
            AppNavigator.pushReplacement(context, const Mainpage());
          });
        } else {
          setState(() {
            _msg = "Invalid Username or password.";
          });
        }
      } else {
        setState(() {
          _msg = "${response.statusCode} ${response.reasonPhrase}";
        });
      }
    } catch (error) {
      setState(() {
        _msg = "$error";
      });
    }
  }
}
