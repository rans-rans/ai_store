abstract class ProductsDataSource {
  Future<List<dynamic>> fetchGeneralProducts(String token);
  Future<Map<String, dynamic>> fetchProductDetails({
    required int productId,
    required int userId,
    required String authToken,
  });
  Future<List<dynamic>> fetchProductsBycategory({
    required int categoryId,
    required String token,
  });
  Future<List<dynamic>> fetchProductRatings({
    required String token,
    required int productId,
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
  Future<dynamic> removeProductRating({
    required int productId,
    required int userId,
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

  factory Rating.fromServer(dynamic data) {
    return Rating(
      productId: data['product_id'],
      userId: data['user_id'],
      comment: data['comment'],
      score: data['score'],
      dateCreated: data['date_created'],
    );
  }
}
