import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchProducts(int userId, String token);
  Future<List<Product>> fetchProductsByCategory({
    required int categoryId,
    required int userId,
    required String token,
  });
  Future<List<Product>> fetchProductsByBrand({
    required int brandID,
    required int userId,
    required String token,
  });
}
