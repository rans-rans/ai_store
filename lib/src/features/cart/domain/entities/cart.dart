abstract class Cart {
  final List<CartItem> products;

  Cart({
    required this.products,
  });

  Map<String, dynamic> toServer();
}

abstract class CartItem {
  final int quantity;
  final String productId;
  final String userId;
  final String itemVariation;

  final double discount;
  final String productName;
  final double productPrice;

  final String imageUrl;

  CartItem({
    required this.quantity,
    required this.productId,
    required this.itemVariation,
    required this.userId,
    required this.discount,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  });

  Map<String, dynamic> toServer();
}
