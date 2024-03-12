import '../../domain/entities/firebase_product.dart';
import '../../domain/entities/product.dart';

import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/products_repository.dart';
import '../data_source/products_datasource.dart';

class FirebaseProductRepository implements ProductsRepository, ProductRepository {
  final ProductsDataSource productsDataSource;

  FirebaseProductRepository({required this.productsDataSource});

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final mapStream = await productsDataSource.fetchGeneralProducts();
      return mapStream.map(FirebaseProduct.fromStorage).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addToCart(String productId) {
    // TODO: implement addToCart
    throw UnimplementedError();
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
    required bool value,
  }) async {
    try {
      return await productsDataSource.toggleFavorite(
        productId: productId,
        userId: userId,
        value: value,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<bool> listenToFavoriteStatus({
    required String productId,
    required String userId,
  }) {
    return productsDataSource.listenToFavoriteStatus(
      productId: productId,
      userId: userId,
    );
  }
}
