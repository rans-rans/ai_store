import '../../domain/entities/cart.dart';
import '../../domain/entities/supabase_cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_datasource.dart';

class SupabaseCartRepository implements CartRepository {
  final CartDatasource cartDatasource;

  SupabaseCartRepository({required this.cartDatasource});
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
  Future<void> changeProductQuantity({
    required String productId,
    required String userId,
    required int quantity,
  }) async {
    try {
      return await cartDatasource.changeProductQuantity(
        productId: productId,
        userId: userId,
        quantity: quantity,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cart> fetchUserCart({required String userId}) async {
    try {
      final request = await cartDatasource.fetchUserCart(userId: userId);
      final products = request.map(SupabaseCartItem.fromStorage).toList();
      final cart = SupabaseCart(products: products);
      return cart;
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

  @override
  Stream<Cart> listenToCart({
    required String userId,
  }) {
    return cartDatasource.listenToCart(userId: userId).map((event) {
      final products = event.map(SupabaseCartItem.fromStorage).toList();
      final cart = SupabaseCart(products: products);
      return cart;
    });
  }
}
