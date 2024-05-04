import 'package:flutter/foundation.dart' show listEquals;

class Product {
  final String name;
  final String brand;
  final bool favorite;
  final int id;
  final int categoryId;
  final int brandId;
  final String category;
  final String description;
  final double discount;
  final int quantity;
  final List<dynamic> images;
  final double price;
  final List<dynamic> variants;
  Product({
    required this.name,
    required this.favorite,
    required this.categoryId,
    required this.brandId,
    required this.quantity,
    required this.brand,
    required this.id,
    required this.category,
    required this.description,
    required this.discount,
    required this.images,
    required this.price,
    required this.variants,
  });

  Product copyWith({
    String? name,
    String? brand,
    int? id,
    String? category,
    String? description,
    double? discount,
    int? quantity,
    bool? favorite,
    int? categoryId,
    int? brandId,
    List<dynamic>? images,
    double? price,
    List<dynamic>? variants,
  }) {
    return Product(
      name: name ?? this.name,
      favorite: favorite ?? this.favorite,
      quantity: quantity ?? this.quantity,
      brand: brand ?? this.brand,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      category: category ?? this.category,
      description: description ?? this.description,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      price: price ?? this.price,
      variants: variants ?? this.variants,
    );
  }

  @override
  String toString() {
    return 'Product(name: $name, brand: $brand, id: $id, category: $category, description: $description, discount: $discount, images: $images, price: $price, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.brand == brand &&
        other.id == id &&
        other.category == category &&
        other.description == description &&
        other.discount == discount &&
        listEquals(other.images, images) &&
        other.price == price &&
        listEquals(other.variants, variants);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        brand.hashCode ^
        id.hashCode ^
        category.hashCode ^
        description.hashCode ^
        discount.hashCode ^
        images.hashCode ^
        price.hashCode ^
        variants.hashCode;
  }
}
