abstract class CartDatasource {
  Future<Map<String, dynamic>> addProductToCart({
    required Map<String, dynamic> cartItem,
  });
  Future<List<Map<String, dynamic>>> fetchUserCart({
    required int userId,
  });
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
  });

  Future<Map<String, dynamic>> changeProductQuantity({
    required int productId,
    required int userId,
    required int quantity,
  });

  Stream<List<Map<String, dynamic>>> listenToCart({
    required int userId,
  });
}
