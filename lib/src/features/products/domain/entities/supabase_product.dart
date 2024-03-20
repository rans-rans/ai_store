import 'product.dart';

class SupabaseProduct extends Product {
  SupabaseProduct({
    required super.name,
    required super.brand,
    required super.quantity,
    required super.variants,
    required super.id,
    required super.category,
    required super.description,
    required super.discount,
    required super.images,
    required super.price,
  });

  factory SupabaseProduct.fromStorage(Map<String, dynamic> data) {
    try {
      List<dynamic> variants = data['variations'];
      variants = variants.toSet().toList();
      return SupabaseProduct(
        name: data['name'],
        brand: data['brand_id'],
        quantity: data['quantity'],
        id: data['product_id'],
        variants: variants,
        category: data['category_id'],
        description: data['description'],
        discount: (data['discount'] / 1.0),
        images: data['image_urls'] ?? [],
        price: (data['price'] / 1.0),
      );
    } catch (e) {
      rethrow;
    }
  }
}
