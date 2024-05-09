import 'product.dart';

class ExpressProduct extends Product {
  ExpressProduct({
    required super.brandId,
    required super.categoryId,
    required super.discount,
    required super.image,
    required super.name,
    required super.ratingScore,
    required super.price,
    required super.productId,
    required super.quantity,
  });

  factory ExpressProduct.fromServer(dynamic data) {
    late int rating;
    String ratingString = data['rating_score'];
    if (ratingString.contains('-')) {
      rating = 0;
    } else {
      ratingString = ratingString.replaceAll('-', '');
      rating = double.parse(ratingString).ceil();
    }
    try {
      return ExpressProduct(
        brandId: data['brand_id'],
        productId: data['id'],
        categoryId: data['category_id'],
        discount: double.parse(data['discount']),
        image: data['image'],
        name: data['name'],
        ratingScore: rating,
        price: double.parse(data['price']),
        quantity: data['quantity'],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Product copyWith(
      {int? brandId,
      int? categoryId,
      String? image,
      String? name,
      int? productId,
      int? ratingScore,
      double? price,
      int? quantity,
      double? discount}) {
    return ExpressProduct(
      brandId: brandId ?? this.brandId,
      categoryId: categoryId ?? this.categoryId,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      name: name ?? this.name,
      ratingScore: ratingScore ?? this.ratingScore,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
