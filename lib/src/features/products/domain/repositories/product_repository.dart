import '../../data/data_source/products_datasource.dart';

abstract class ProductRepository {
  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required int productId,
  });
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
  });

  Future<Map<String, dynamic>> rateProduct(Rating rating);
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
  });

  Stream<bool> listenToFavoriteStatus({
    required int productId,
    required int userId,
  });
}
