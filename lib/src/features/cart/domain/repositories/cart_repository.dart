import '../entities/cart.dart';

abstract class CartRepository {
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  });
  Stream<Cart> fetchUserCart({
    required String userId,
  });
  Future<void> removeProductFromCart({
    required String productId,
    required String userId,
  });

  Future<void> incrementItemQuantity({
    required String productId,
    required String userId,
  });
  Future<void> decrementItemQuantity({
    required String productId,
    required String userId,
  });
}
