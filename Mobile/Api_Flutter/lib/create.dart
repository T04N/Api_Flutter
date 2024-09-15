import 'package:flutter/material.dart';

import 'models/product.dart';

class CreateProductForm extends StatefulWidget {
  @override
  _CreateProductFormState createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void _createProduct() {
    String name = nameController.text;
    String price = priceController.text;
    String desc = descController.text;

    // Generate an ID (you could improve this logic based on your needs)
    int id = DateTime.now().millisecondsSinceEpoch; // or any other logic for unique ID

    if (name.isNotEmpty && price.isNotEmpty && desc.isNotEmpty) {
      // Correct order for Product constructor (id, name, price, desc)
      Product newProduct = Product(id, name, price, desc);

      // Return the Product object to the previous screen
      Navigator.of(context).pop<Product>(newProduct);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name here'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price here'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Desc here'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createProduct,
              child: Text('Create Data'),
            ),
          ],
        ),
      ),
    );
  }
}
