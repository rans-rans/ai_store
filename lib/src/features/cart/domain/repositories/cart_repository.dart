import '../entities/cart.dart';

abstract class CartRepository {
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  });
  Future<Cart> fetchUserCart({
    required String userId,
  });
  Future<void> removeProductFromCart({
    required String productId,
    required String userId,
  });
  Future<void> changeProductQuantity({
    required String productId,
    required String userId,
    required int quantity,
  });

  Stream<Cart> listenToCart({required String userId});
}
