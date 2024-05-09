import 'product_details.dart';

class ExpressProductDetails extends ProductDetails {
  ExpressProductDetails(
      {required super.brand,
      required super.category,
      required super.description,
      required super.discount,
      required super.isFavorite,
      required super.images,
      required super.name,
      required super.price,
      required super.productId,
      required super.quantity,
      required super.variants});

  factory ExpressProductDetails.fromServer(Map<String, dynamic> data) {
    return ExpressProductDetails(
      brand: data['brand_name'],
      category: data['category_name'],
      description: data['description'],
      discount: double.parse(data['discount']),
      images: [...data['images']],
      name: data['name'],
      price: double.parse(data['price']),
      productId: data['id'],
      quantity: data['quantity'],
      variants: [...data['variants']],
      isFavorite: data['is_favorite'] == 1 ? true : false,
    );
  }
}
