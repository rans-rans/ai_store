import 'package:flutter/foundation.dart' show listEquals;

abstract class ProductDetails {
  final String brand;
  final String category;
  final String description;
  final double discount;
  final bool isFavorite;
  final List<String> images;
  final String name;
  final double price;
  final int productId;
  final int quantity;
  final List<dynamic> variants;

  ProductDetails(
      {required this.brand,
      required this.category,
      required this.description,
      required this.discount,
      required this.isFavorite,
      required this.images,
      required this.name,
      required this.price,
      required this.productId,
      required this.quantity,
      required this.variants});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDetails &&
        other.brand == brand &&
        other.category == category &&
        other.description == description &&
        other.discount == discount &&
        other.isFavorite == isFavorite &&
        listEquals(other.images, images) &&
        other.name == name &&
        other.price == price &&
        other.productId == productId &&
        other.quantity == quantity &&
        listEquals(other.variants, variants);
  }

  @override
  int get hashCode {
    return brand.hashCode ^
        category.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        images.hashCode ^
        name.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        variants.hashCode;
  }

  @override
  String toString() {
    return """ProductDetails(brand: $brand, category: $category, description:
     $description, favorite: $isFavorite, images: $images, name: $name, price: $price,
      productId: $productId, quantity: $quantity, variants: $variants, 
      discount: $discount)""";
  }
}
