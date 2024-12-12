import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  String _msg = "";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  labelText: "Username", hintText: "Enter Username"),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Password", hintText: "Enter Password"),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text(
                "Login",
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              _msg,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      )),
    );
  }

  void login() async {
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
            _msg = user[0]['first_name'];
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
