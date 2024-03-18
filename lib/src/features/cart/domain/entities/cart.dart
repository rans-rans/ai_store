abstract class Cart {
  final String userId;
  final List<CartItem> products;

  Cart({required this.userId, required this.products});

  Map<String, dynamic> toServer();
}

abstract class CartItem {
  final String name;
  final String productId;
  final int quantity;
  final double price;
  final String image;

  CartItem({
    required this.name,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.image,
  });

  // 'quantity': quantity,
  // 'price': product.price,
  // 'name': product.name,
  // 'image': product.images.first,

  Map<String, dynamic> toServer();
}
