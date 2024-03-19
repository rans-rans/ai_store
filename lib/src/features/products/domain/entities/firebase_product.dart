import 'product.dart';

class FirebaseProduct extends Product {
  FirebaseProduct({
    required super.name,
    required super.quantity,
    required super.brand,
    required super.id,
    required super.category,
    required super.description,
    required super.variants,
    required super.discount,
    required super.images,
    required super.price,
  });

  factory FirebaseProduct.fromStorage(Map<String, dynamic> data) {
    return FirebaseProduct(
      name: data['name'] ?? "",
      brand: data['brand'] ?? "",
      id: data['id'],
      quantity: 10,
      variants: data['variant'] ?? [],
      category: data['category'] ?? [],
      description: data['description'] ?? "",
      discount: (data['discount'] / 1.0) ?? 0.0,
      images: data['images'] ?? [],
      price: (data['price'] / 1.0) ?? 0.0,
    );
  }
}
