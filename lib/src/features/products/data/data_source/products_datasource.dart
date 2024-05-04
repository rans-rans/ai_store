abstract class ProductsDataSource {
  Future<List<Map<String, dynamic>>> fetchGeneralProducts(int userId);
  Future<List<Map<String, dynamic>>> fetchProductsByBrand({
    required int brandID,
    required int userId,
  });
  Future<List<Map<String, dynamic>>> fetchProductsBycategory({
    required int categoryId,
    required int userId,
  });

  Future<Map<String, dynamic>> saveProduct({
    required int userId,
    required int productId,
  });
  Future<Map<String, dynamic>> toggleFavorite({
    required int productId,
    required int userId,
  });
  Future<Map<String, dynamic>> rateProduct(Rating rating);
  Future<Map<String, dynamic>> removeSavedProduct({
    required int userId,
    required int productId,
  });

  Stream<bool> listenToFavoriteStatus({
    required int productId,
    required int userId,
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
      'user_id': userId,
      'score': score,
      'comment': comment,
      'date_created': dateCreated
    };
  }
}
