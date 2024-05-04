import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchProducts(int userId);
  Future<List<Product>> fetchProductsByCategory({
    required int categoryId,
    required int userId,
  });
  Future<List<Product>> fetchProductsByBrand({
    required int brandID,
    required int userId,
  });
}
