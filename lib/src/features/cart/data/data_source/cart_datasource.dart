import '../../domain/entities/cart.dart';

abstract class CartDatasource {
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  });
  Stream<List<Map<String, dynamic>>> fetchUserCart({
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
