import '../entities/cart.dart';

abstract class CartRepository {
  Future<Map<String, dynamic>> addProductToCart({
    required Map<String, dynamic> cartItem,
    required String token,
  });
  Future<Cart> fetchUserCart({
    required int userId,
    required String token,
  });
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
    required String token,
  });
  Future<Map<String, dynamic>> changeProductQuantity({
    required int productId,
    required int userId,
    required int quantity,
    required String token,
  });
  Cart clearCart();
}
