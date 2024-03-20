import '../../../../constants/objects.dart';
import 'products_datasource.dart';

class SupabaseProductsDatasource implements ProductsDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchGeneralProducts() async {
    try {
      final response = await supabaseInstance.rpc('fetchgeneralproducts').limit(20)
          as List<dynamic>;
      return response.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProductsByBrand({
    required String brandID,
  }) async {
    try {
      final response = await supabaseInstance.rpc(
        'fetchproductsbrand',
        params: {'p_brand_id': brandID},
      ) as List<dynamic>;
      return response.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProductsBycategory({
    required String categoryId,
  }) async {
    try {
      final response = await supabaseInstance.rpc(
        'fetchproductsbycategory',
        params: {'p_category_id': categoryId},
      ) as List<dynamic>;
      return response.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<bool> listenToFavoriteStatus(
      {required String productId, required String userId}) {
    try {
      final request = supabaseInstance
          .from('favorites')
          .stream(primaryKey: ['product_id', 'user_id']).inFilter(
              'user_id', [userId]).map((product) {
        final contains = product.any(
          (element) => element['product_id'] == productId,
        );
        return contains;
      });
      return request;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rateProduct(String productId) {
    // TODO: implement rateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> removeSavedProduct(String productId) {
    // TODO: implement removeSavedProduct
    throw UnimplementedError();
  }

  @override
  Future<void> saveProduct(String productId) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(
      {required String productId, required String userId}) async {
    try {
      return await supabaseInstance.rpc('toggleproductfavorite', params: {
        'p_user_id': userId,
        'p_product_id': productId,
      });
    } catch (e) {
      rethrow;
    }
  }
}
