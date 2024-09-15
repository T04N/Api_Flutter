class Product {
  final String? name;
  final int id;
  final String? price;
  final String? desc;

  // Constructor thông thường
  Product(this.id, this.name, this.price, this.desc);

  // Factory constructor tùy chỉnh để tạo id nếu cần
  factory Product.create(List<Product> products, {String? name, String? price, String? desc, int? id}) {
    return Product(
      id ?? products.length + 1, // Nếu id không được truyền vào thì tạo một id mới dựa trên chiều dài danh sách
      name,
      price,
      desc,
    );
  }
}
