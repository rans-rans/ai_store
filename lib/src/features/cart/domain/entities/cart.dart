class Cart {
  final List<CartItem> products;

  Cart({
    required this.products,
  });

  Cart copyWith({List<CartItem>? products}) {
    return Cart(products: products ?? this.products);
  }
}

abstract class CartItem {
  int quantity;
  final int productId;
  final int userId;
  final String itemVariation;

  final double discount;
  final String productName;
  final double productPrice;

  final String imageUrl;

  CartItem({
    required this.quantity,
    required this.productId,
    required this.userId,
    required this.itemVariation,
    required this.discount,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });

  Map<String, dynamic> toServer() {
    return {
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
      'variant': itemVariation,
    };
  }

  CartItem copyWith({
    int? quantity,
    int? productId,
    int? userId,
    String? itemVariation,
    double? discount,
    String? productName,
    double? productPrice,
    String? imageUrl,
  });

  @override
  String toString() {
    return 'CartItem(quantity: $quantity, productId: $productId, userId: $userId, itemVariation: $itemVariation, discount: $discount, productName: $productName, productPrice: $productPrice, imageUrl: $imageUrl)';
  }
}
