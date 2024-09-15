import 'package:flutter/material.dart';
import 'package:restapinodejs/models/product.dart';
import 'package:restapinodejs/service/api.dart';
import 'create.dart';
import 'edit.dart';
import 'fetch.dart'; // Ensure correct import of file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> postProduct(BuildContext context) async {
    Product? newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateProductForm()),
    );

    if (newProduct != null) {
      var pdata = {
        "pname": newProduct.name,
        "pprice": newProduct.price,
        "pdesc": newProduct.desc
      };

      try {
        await Api.addProduct(pdata);  // Ensure asynchronous call is awaited
        print(newProduct.name);
      } catch (e) {
        print('Error adding product: $e');  // Proper error handling
      }
    }
  }

  Future<void> editProduct(BuildContext context, Product product) async {
    Product? updateProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProductForm(product: product)),
    );

    if (updateProduct != null) {
      var pData = {
        "pname": updateProduct.name,
        "pprice": updateProduct.price,
        "pdesc": updateProduct.desc
      };

      try {
        await Api.updateProduct(product.id, pData);  // Corrected call with product.id and correct variable name
      } catch (e) {
        print('Error updating product: $e');  // Proper error handling
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baaba Devs: Node Tutorials'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                postProduct(context);
              },
              child: Text('CREATE'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const FetchData()));
              },
              child: Text('GET'),
            ),
            ElevatedButton(
              onPressed: () {
                Api.getProduct();
              },
              child: Text('test'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ensure existingProduct is defined or fetched from somewhere
                Product existingProduct = Product(1, "Sample", "100", "Description"); // Example definition
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductForm(product: existingProduct),
                  ),
                );
              },
              child: Text('EDIT'),
            ),
          ],
        ),
      ),
    );
  }
}
