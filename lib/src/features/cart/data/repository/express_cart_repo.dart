import '../../domain/entities/cart.dart';
import '../../domain/entities/express_cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_source/cart_datasource.dart';

class ExpressCartRepo implements CartRepository {
  final CartDatasource datasource;

  ExpressCartRepo({required this.datasource});
  @override
  Future<Map<String, dynamic>> addProductToCart({
    required Map<String, dynamic> cartItem,
    required String token,
  }) async {
    try {
      return await datasource.addProductToCart(
        cartItem: cartItem,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> changeProductQuantity({
    required int productId,
    required int userId,
    required int quantity,
    required String token,
  }) async {
    try {
      return await datasource.changeProductQuantity(
        productId: productId,
        userId: userId,
        quantity: quantity,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cart> fetchUserCart({
    required int userId,
    required String token,
  }) async {
    try {
      final request = await datasource.fetchUserCart(
        userId: userId,
        token: token,
      );
      final response = request.map(ExpressCartItem.fromServer).toList();
      return ExpressCart(products: response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      return await datasource.removeProductFromCart(
        productId: productId,
        userId: userId,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Cart clearCart() {
    return ExpressCart(products: []);
  }
}
