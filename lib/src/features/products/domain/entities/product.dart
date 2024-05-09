abstract class Product {
  final int ratingScore;
  final int brandId;
  final int quantity;
  final int categoryId;
  final String image;
  final String name;
  final int productId;
  final double price;
  final double discount;
  Product({
    required this.brandId,
    required this.categoryId,
    required this.discount,
    required this.image,
    required this.name,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.ratingScore,
  });

  Product copyWith({
    int? ratingScore,
    int? brandId,
    int? categoryId,
    String? image,
    String? name,
    int? productId,
    double? price,
    int? quantity,
    double? discount,
  });

  @override
  String toString() {
    return """Product(averageScore: $ratingScore, brandId: $brandId, 
    categoryId: $categoryId, image: $image, name: $name, productId: $productId, 
    price: $price, discount: $discount, quantity: $quantity)""";
  }

  Map<String, dynamic> toMap() {
    return {
      'average_score': ratingScore,
      'brand_id': brandId,
      'category_id': categoryId,
      'image': image,
      'name': name,
      'product_id': productId,
      'price': price,
      'discount': discount,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.ratingScore == ratingScore &&
        other.brandId == brandId &&
        other.categoryId == categoryId &&
        other.image == image &&
        other.name == name &&
        other.productId == productId &&
        other.price == price &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return ratingScore.hashCode ^
        brandId.hashCode ^
        categoryId.hashCode ^
        image.hashCode ^
        name.hashCode ^
        productId.hashCode ^
        price.hashCode ^
        discount.hashCode;
  }
}
