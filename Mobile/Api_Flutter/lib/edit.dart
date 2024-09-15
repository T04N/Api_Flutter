import 'package:flutter/material.dart';
import 'models/product.dart';

class EditProductForm extends StatefulWidget {
  final Product product; // Product to be edited

  EditProductForm({required this.product});

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController idController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the product data
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price);
    idController = TextEditingController(text: widget.product.id.toString());
    descController = TextEditingController(text: widget.product.desc);
  }

  void _editProduct() {
    String name = nameController.text;
    String price = priceController.text;
    String desc = descController.text;
    int id = int.parse(idController.text); // Even though the ID field is read-only, we can still parse it.

    if (name.isNotEmpty && price.isNotEmpty && desc.isNotEmpty) {
      // Create an updated Product object with the correct constructor arguments
      Product updatedProduct = Product(id, name, price, desc);

      // Return the updated Product object to the previous screen
      Navigator.of(context).pop<Product>(updatedProduct);
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
    idController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
              controller: idController,
              decoration: InputDecoration(labelText: 'ID here'),
              keyboardType: TextInputType.number,
              enabled: false, // ID is usually not edited, so it's disabled
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Description here'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _editProduct,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
