import 'product.dart';

class ExpressProduct extends Product {
  ExpressProduct({
    required super.name,
    required super.favorite,
    required super.quantity,
    required super.brand,
    required super.id,
    required super.category,
    required super.description,
    required super.discount,
    required super.images,
    required super.price,
    required super.variants,
    required super.categoryId,
    required super.brandId,
  });

  factory ExpressProduct.fromStorage(Map<String, dynamic> data) {
    try {
      final images = data['images'] as List<dynamic>;
      final variants = data['variants'];
      return ExpressProduct(
        id: data['id'],
        name: data['name'],
        favorite: data['is_favorite'] == 1,
        categoryId: data['category_id'],
        brandId: data['brand_id'],
        brand: data['brand_name'],
        quantity: data['quantity'],
        variants: variants,
        category: data['category_name'],
        description: data['description'],
        discount: double.parse(data['discount']),
        images: images,
        price: double.parse(data['price']),
      );
    } catch (e) {
      rethrow;
    }
  }
}
