import 'cart.dart';

class SupabaseCart extends Cart {
  SupabaseCart({
    required super.products,
  });

  @override
  Map<String, dynamic> toServer() {
    final data = <String, dynamic>{};
    for (var product in products) {
      data['id'] = product.productId;
      data['quantity'] = product.quantity;
      data['name'] = product.productName;
      data['variant'] = product.itemVariation;
      data['price'] = product.productPrice;
      data['discount'] = product.discount;
    }
    return data;
  }
}

class SupabaseCartItem extends CartItem {
  SupabaseCartItem({
    required super.quantity,
    required super.itemVariation,
    required super.productId,
    required super.userId,
    required super.productName,
    required super.discount,
    required super.productPrice,
    required super.imageUrl,
  });

  @override
  Map<String, dynamic> toServer() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'user_id': userId,
      'item_variant': itemVariation,
    };
  }

  factory SupabaseCartItem.fromStorage(Map<String, dynamic> data) {
    return SupabaseCartItem(
      discount: data['discount'],
      itemVariation: data['item_variant'],
      quantity: data['quantity'],
      productId: data['product_id'],
      userId: data['user_id'],
      productName: data['product_name'],
      productPrice: (data['product_price'] / 1.0),
      imageUrl: data['image_url'],
    );
  }
}
