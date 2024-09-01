import 'cart.dart';

class ExpressCart extends Cart {
  ExpressCart({required super.products});
}

class ExpressCartItem extends CartItem {
  ExpressCartItem({
    required super.quantity,
    required super.productId,
    required super.userId,
    required super.discount,
    required super.productName,
    required super.productPrice,
    required super.imageUrl,
  });

  factory ExpressCartItem.fromServer(Map<String, dynamic> data) {
    try {
      return ExpressCartItem(
        productName: data['name'],
        productPrice: double.parse(data['price']),
        discount: double.parse(data['discount']),
        productId: data['id'],
        quantity: data['quantity'],
        userId: data['user_id'],
        imageUrl: (data['images'] as List).first,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  CartItem copyWith(
      {int? quantity,
      int? productId,
      int? userId,
      double? discount,
      String? productName,
      double? productPrice,
      String? imageUrl}) {
    return ExpressCartItem(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      discount: discount ?? this.discount,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
