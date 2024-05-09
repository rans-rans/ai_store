abstract class ProductsDataSource {
  Future<List<Map<String, dynamic>>> fetchGeneralProducts(String token);
  Future<Map<String, dynamic>> fetchProductDetails({
    required int productId,
    required int userId,
    required String authToken,
  });
  Future<List<Map<String, dynamic>>> fetchProductsByBrand({
    required int brandID,
    required String token,
  });
  Future<List<Map<String, dynamic>>> fetchProductsBycategory({
    required int categoryId,
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
  Future<Map<String, dynamic>> rateProduct(Rating rating, String token);
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
    required String token,
  });
}

class Rating {
  final int productId;
  final String comment;
  final int userId;
  final int score;
  final String dateCreated;

  Rating({
    required this.productId,
    required this.userId,
    required this.comment,
    required this.score,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'id': userId,
      'score': score,
      'comment': comment,
      'date_created': dateCreated
    };
  }
}
