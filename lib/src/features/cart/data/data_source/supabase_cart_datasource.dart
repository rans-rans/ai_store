import '../../../../constants/objects.dart';
import '../../domain/entities/cart.dart';
import 'cart_datasource.dart';

class SupabaseCartDatasource implements CartDatasource {
  @override
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  }) async {
    try {
      return await supabaseInstance.from('cart_items').insert(cartItem.toServer());
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
      return await supabaseInstance
          .from('cart_items')
          .update({'quantity': quantity})
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchUserCart({
    required String userId,
  }) async {
    try {
      final response = await supabaseInstance.rpc(
        'fetchusercart',
        params: {'p_user_id': userId},
      ) as List<dynamic>;
      return response.map((e) => e as Map<String, dynamic>).toList();
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
      return await supabaseInstance.from('cart_items').delete().match({
        'user_id': userId,
        'product_id': productId,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> listenToCart({required String userId}) {
    try {
      return supabaseInstance
          .from('cart_view')
          .stream(primaryKey: ['user_id', 'product_id']).eq('user_id', userId);
    } catch (e) {
      rethrow;
    }
  }
}
