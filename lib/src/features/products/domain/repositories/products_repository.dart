import '../../data/data_source/products_datasource.dart';
import '../entities/product.dart';
import '../entities/product_details.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchProducts(String token);
  Future<ProductDetails> fetchProductDetails({
    required int productId,
    required int userId,
    required String token,
  });
  Future<List<Product>> fetchProductsByCategory({
    required int categoryId,
    required String token,
  });
  Future<List<Rating>> fetchProductRatings({
    required String token,
    required int productId,
  });
  Future<bool> rateProduct(Rating rating, String token);
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
    required String token,
  });
  Future<bool> removeProductRating({
    required int productId,
    required int userId,
    required String token,
  });
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
}
