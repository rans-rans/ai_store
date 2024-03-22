import '../../domain/entities/cart.dart';

abstract class CartDatasource {
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  });
  Future<List<Map<String, dynamic>>> fetchUserCart({
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

  Stream<List<Map<String, dynamic>>> listenToCart({
    required String userId,
  });
}
