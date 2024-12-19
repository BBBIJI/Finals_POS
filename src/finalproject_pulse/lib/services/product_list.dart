import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<dynamic> _productsList = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Fetch products and update the state
    List myList = await getProducts();
    setState(() {
      _productsList = myList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for adding a product
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Products",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getProducts(),
                  builder: (context, snapShot) {
                    switch (snapShot.connectionState) {
                      case ConnectionState.waiting:
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Loading..."),
                          ],
                        );
                      case ConnectionState.done:
                        if (snapShot.hasError) {
                          return Text("Error: ${snapShot.error}");
                        }
                        return productsListView();
                      default:
                        return Text("Error: ${snapShot.error}");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget productsListView() {
    return ListView.builder(
      itemCount: _productsList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text(_productsList[index]['product_name']),
            subtitle: Text("\$${_productsList[index]['unit_price']}"),
            trailing: const Icon(Icons.arrow_right),
          ),
        );
      },
    );
  }

  Future<List> getProducts() async {
    String url = "http://localhost/flutter/api/getAllProducts.php";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var products = jsonDecode(response.body);
      return products;
    } else {
      return [];
    }
  }
}
