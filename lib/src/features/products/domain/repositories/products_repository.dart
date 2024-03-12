import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchProducts();
  Future<List<Product>> fetchProductsByCategory({required String categoryId});
  Future<List<Product>> fetchProductsByBrand({required String brandName});
}
