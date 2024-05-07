import '../../data/data_source/products_datasource.dart';

abstract class ProductRepository {
  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required int productId,
    required String token,
  });
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
    required String token,
  });

  Future<Map<String, dynamic>> rateProduct(Rating rating, String token);
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
    required String token,
  });
}
