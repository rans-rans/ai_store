import 'package:ai_store/src/features/cart/domain/entities/cart.dart';

import '../../domain/entities/firebase_cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_datasource.dart';

class FirebaseCartRepository implements CartRepository {
  final CartDatasource cartDatasource;

  FirebaseCartRepository({required this.cartDatasource});
  @override
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  }) async {
    try {
      return await cartDatasource.addProductToCart(
        cartItem: cartItem,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> incrementItemQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      return await cartDatasource.incrementItemQuantity(
        productId: productId,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> decrementItemQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      return await cartDatasource.decrementItemQuantity(
        productId: productId,
        userId: userId,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<Cart> fetchUserCart({
    required String userId,
  }) {
    try {
      return cartDatasource.fetchUserCart(userId: userId).map((event) {
        final products = event.map(FirebaseCartItem.fromServer).toList();
        return FirebaseCart(
          userId: userId,
          products: products,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeProductFromCart({
    required String productId,
    required String userId,
  }) async {
    try {
      return await cartDatasource.removeProductFromCart(
        productId: productId,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
