import '../entities/cart.dart';

abstract class CartRepository {
  Future<Map<String, dynamic>> addProductToCart({
    required Map<String, dynamic> cartItem,
  });
  Future<Cart> fetchUserCart({
    required int userId,
  });
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
  });
  Future<Map<String, dynamic>> changeProductQuantity({
    required int productId,
    required int userId,
    required int quantity,
  });

  Stream<Cart> listenToCart({required int userId});
}
