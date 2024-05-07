abstract class CartDatasource {
  Future<Map<String, dynamic>> addProductToCart({
    required Map<String, dynamic> cartItem,
    required String token,
  });
  Future<List<Map<String, dynamic>>> fetchUserCart({
    required int userId,
    required String token,
  });
  Future<Map<String, dynamic>> removeProductFromCart({
    required int productId,
    required int userId,
    required String token,
  });

  Future<Map<String, dynamic>> changeProductQuantity({
    required int productId,
    required int userId,
    required int quantity,
    required String token,
  });
}
