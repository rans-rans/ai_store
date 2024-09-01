abstract class ProductDetails {
  final double averageRating;
  final String category;
  final String description;
  final double discount;
  final bool isFavorite;
  final String images;
  final String name;
  final double price;
  final int productId;
  final int quantity;

  ProductDetails({
    required this.category,
    required this.averageRating,
    required this.description,
    required this.discount,
    required this.isFavorite,
    required this.images,
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDetails &&
        other.category == category &&
        other.description == description &&
        other.averageRating == averageRating &&
        other.discount == discount &&
        other.isFavorite == isFavorite &&
        other.images == images &&
        other.name == name &&
        other.price == price &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        description.hashCode ^
        isFavorite.hashCode ^
        images.hashCode ^
        name.hashCode ^
        averageRating.hashCode ^
        price.hashCode ^
        productId.hashCode ^
        quantity.hashCode;
  }

  @override
  String toString() {
    return """ProductDetails(category: $category, description:
     $description, favorite: $isFavorite, images: $images, name: $name, price: $price,
      productId: $productId, quantity: $quantity,
      discount: $discount, average_rating: $averageRating)""";
  }
}
