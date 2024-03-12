abstract class ProductsDataSource {
  Future<List<Map<String, dynamic>>> fetchGeneralProducts();
  Future<void> saveProduct(String productId);
  Future<void> toggleFavorite({
    required String productId,
    required String userId,
    required bool value,
  });
  Future<void> addToCart(String productId);
  Future<void> rateProduct(String productId);
  Future<void> removeSavedProduct(String productId);

  Stream<bool> listenToFavoriteStatus({
    required String productId,
    required String userId,
  });
}
