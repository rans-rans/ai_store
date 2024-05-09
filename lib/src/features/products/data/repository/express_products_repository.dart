import '../../domain/entities/express_product.dart';
import '../../domain/entities/express_product_details.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_details.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_source/express_products_datasource.dart';
import '../data_source/products_datasource.dart';

class ExpressProductsRepository implements ProductsRepository {
  final ExpressProductsDatasource datasource;

  ExpressProductsRepository({required this.datasource});
  @override
  Future<List<Product>> fetchProducts(String token) async {
    try {
      final response = await datasource.fetchGeneralProducts(token);
      final products = response.map(ExpressProduct.fromServer);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductDetails> fetchProductDetails({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      final request = await datasource.fetchProductDetails(
        productId: productId,
        userId: userId,
        authToken: token,
      );
      final product = ExpressProductDetails.fromServer(request);
      return product;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByBrand({
    required int brandId,
    required String token,
  }) async {
    try {
      final response = await datasource.fetchProductsByBrand(
        brandID: brandId,
        token: token,
      );
      final products = response.map(ExpressProduct.fromServer);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory({
    required int categoryId,
    required String token,
  }) async {
    try {
      final response = await datasource.fetchProductsBycategory(
        categoryId: categoryId,
        token: token,
      );
      final products = response.map(ExpressProduct.fromServer);
      return products.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Rating>> fetchProductRatings({
    required String token,
    required int productId,
  }) async {
    try {
      final request = await datasource.fetchProductRatings(
        token: token,
        productId: productId,
      );
      final ratings = request.map(Rating.fromServer).toList();
      return ratings;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> rateProduct(Rating rating, String token) async {
    try {
      final response = await datasource.rateProduct(rating, token);
      final status = response['status'] as bool;
      return status;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeProductRating({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      final request = await datasource.removeProductRating(
        productId: productId,
        userId: userId,
        token: token,
      );
      return request['status'] == true;
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
