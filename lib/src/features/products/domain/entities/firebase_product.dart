import 'product.dart';

class FirebaseProduct extends Product {
  FirebaseProduct(
      {required super.name,
      required super.brand,
      required super.id,
      required super.category,
      required super.description,
      required super.variants,
      required super.discount,
      required super.images,
      required super.price,
      required super.subCategories});

  Product copyWith({
    String? name,
    String? id,
    String? category,
    String? description,
    String? brand,
    double? discount,
    List<String>? images,
    List<String>? variants,
    double? price,
    List<String>? subCategories,
  }) {
    return Product(
      name: name ?? this.name,
      brand: brand ?? this.brand,
      id: id ?? this.id,
      variants: variants ?? this.variants,
      category: category ?? this.category,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      price: price ?? this.price,
      subCategories: subCategories ?? this.subCategories,
    );
  }

  @override
  String toString() {
    return 'Product(name: $name, brand: $brand, id: $id, category: $category, description: $description, discount: $discount, images: $images, price: $price, subCategories: $subCategories)';
  }

  factory FirebaseProduct.fromStorage(Map<String, dynamic> data) {
    return FirebaseProduct(
      name: data['name'] ?? "",
      brand: data['brand'] ?? "",
      id: data['id'],
      variants: data['variant'] ?? [],
      category: data['category'] ?? "",
      description: data['description'] ?? "",
      discount: (data['discount'] / 1.0) ?? 0.0,
      images: data['images'] ?? [],
      price: (data['price'] / 1.0) ?? 0.0,
      subCategories: data['sub-categories'] ?? [],
    );
  }
}
