import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Api {
  static const baseUrl = "http://192.168.1.8:2000/api/";

  static addProduct(Map pdata) async {
    var url = Uri.parse("${baseUrl}add_product");

    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print("success");
        print(data);
      } else {
        print("fail to get response");
      }
    } catch (e) {
      print("error");
      debugPrint(e.toString());
    }
  }

  static Future<List<Product>> getProduct() async {
    List<Product> products = [];

    var url = Uri.parse("${baseUrl}get_product");
    print(url);
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        // Debug để kiểm tra dữ liệu phản hồi
        print("Response data: $data");

        if (data != null && data['products'] != null) {
          data['products'].forEach((value) {
            products
                .add(Product(value['id'], value['pname'], value['pprice'], value['pdesc'], ));
          });
        } else {
          print("No products found in response");
        }
      } else {
        print("Failed to load data: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred during GET request");
      debugPrint(e.toString());
    }

    return products;
  }

  static updateProduct(id, Map pdata) async {
    var url = Uri.parse("${baseUrl}update/$id");

    final res = await http.put(url, body: pdata);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print("Product updated successfully: $data");

    } else {
      print("Failed to update product. Status code: ${res.statusCode}");
    }
  }


  static deleteProduct(id) async {
    var url = Uri.parse("${baseUrl}delete/$id");
    final res = await http.post(url);
    if (res.statusCode == 204) { 
      print(jsonDecode(res.body));
    } else {
      print("failt to delete");
  }
}}
