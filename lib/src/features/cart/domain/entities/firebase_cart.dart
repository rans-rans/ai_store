import 'cart.dart';

class FirebaseCart extends Cart {
  FirebaseCart({required super.userId, required super.products});

  @override
  Map<String, dynamic> toServer() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  factory FirebaseCart.fromServer(Map<String, dynamic> data) {
    final products = data['products'];
    return FirebaseCart(
      userId: data['userId'],
      products: products,
    );
  }
}

class FirebaseCartItem extends CartItem {
  FirebaseCartItem(
      {required super.name,
      required super.productId,
      required super.quantity,
      required super.price,
      required super.image});

  @override
  Map<String, dynamic> toServer() {
    return {
      'quantity': quantity,
      'price': price,
      'name': name,
      'productId': productId,
      'image': image,
    };
  }

  factory FirebaseCartItem.fromServer(Map<String, dynamic> data) {
    return FirebaseCartItem(
      name: data['name'],
      productId: data['productId'],
      quantity: data['quantity'],
      price: data['price'],
      image: data['image'],
    );
  }
}
