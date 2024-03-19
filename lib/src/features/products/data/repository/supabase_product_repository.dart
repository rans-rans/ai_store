import '../../domain/entities/product.dart';
import '../../domain/entities/supabase_product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_source/products_datasource.dart';

class SupabaseProductRepository implements ProductsRepository, ProductRepository {
  final ProductsDataSource productsDataSource;

  SupabaseProductRepository({required this.productsDataSource});
  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final request = await productsDataSource.fetchGeneralProducts();
      final response = request.map(SupabaseProduct.fromStorage).toList();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByBrand({required String brandID}) async {
    try {
      final request =
          await productsDataSource.fetchProductsByBrand(brandID: brandID);
      final response = request.map(SupabaseProduct.fromStorage);
      return response.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory({required String categoryId}) async {
    try {
      final request =
          await productsDataSource.fetchProductsBycategory(categoryId: categoryId);
      final response = request.map(SupabaseProduct.fromStorage);
      return response.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<bool> listenToFavoriteStatus(
      {required String productId, required String userId}) {
    try {
      return productsDataSource.listenToFavoriteStatus(
        productId: productId,
        userId: userId,
      );
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
  Future<void> toggleFavorite({
    required String productId,
    required String userId,
  }) async {
    try {
      return await productsDataSource.toggleFavorite(
        productId: productId,
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
