import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapinodejs/service/api.dart';

import 'models/product.dart';

class FetchData extends StatelessWidget {
  const FetchData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: Api.getProduct(),  // Tương tác với API để lấy dữ liệu
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(), // Hiển thị vòng tròn chờ đợi khi dữ liệu đang được tải
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'), // Hiển thị lỗi nếu có
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No data available'), // Hiển thị khi không có dữ liệu
              );
            } else {
              List<Product> pdata = snapshot.data!; // Lưu trữ dữ liệu từ snapshot
              return ListView.builder(
                itemCount: pdata.length,  // Số lượng sản phẩm được lấy từ dữ liệu
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.storage),  // Hiển thị biểu tượng kho lưu trữ trước mỗi mục
                    title: Text("${pdata[index].name}"),  // Hiển thị tên sản phẩm
                    subtitle: Text("${pdata[index].desc}"),  // Hiển thị thêm mô tả sản phẩm
                    trailing: Text("\$ ${pdata[index].price}"),  // Hiển thị giá của sản phẩm ở góc phải
                  );
                },
              );
            }
          },
        )

    );
  }
}
