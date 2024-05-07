import '../../domain/entities/express_product.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_source/express_products_datasource.dart';
import '../data_source/products_datasource.dart';

class ExpressProductsRepository implements ProductsRepository, ProductRepository {
  final ExpressProductsDatasource datasource;

  ExpressProductsRepository({required this.datasource});
  @override
  Future<List<Product>> fetchProducts(int userId, String token) async {
    try {
      final response = await datasource.fetchGeneralProducts(userId, token);
      final products = response.map(ExpressProduct.fromStorage);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByBrand(
      {required int brandID, required int userId, required String token}) async {
    try {
      final response = await datasource.fetchProductsByBrand(
        brandID: brandID,
        userId: userId,
        token: token,
      );
      final products = response.map(ExpressProduct.fromStorage);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory({
    required int categoryId,
    required int userId,
    required String token,
  }) async {
    try {
      final response = await datasource.fetchProductsBycategory(
        categoryId: categoryId,
        userId: userId,
        token: token,
      );
      final products = response.map(ExpressProduct.fromStorage);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> rateProduct(Rating rating, String token) async {
    try {
      return await datasource.rateProduct(rating, token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> removeSavedProduct({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      return await datasource.removeSavedProduct(
          userId: userId, productId: productId, token: token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required int productId,
    required String token,
  }) async {
    try {
      return await datasource.saveProduct(
          userId: userId, productId: productId, token: token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      return await datasource.toggleFavorite(
        productId: productId,
        userId: userId,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }
}
