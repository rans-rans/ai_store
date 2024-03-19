abstract class ProductRepository {
  Future<void> saveProduct(String productId);
  Future<void> toggleFavorite({
    required String productId,
    required String userId,
  });

  Future<void> rateProduct(String productId);
  Future<void> removeSavedProduct(String productId);

  Stream<bool> listenToFavoriteStatus({
    required String productId,
    required String userId,
  });
}
