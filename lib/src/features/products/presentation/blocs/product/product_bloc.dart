import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_source/products_datasource.dart';
import '../../../domain/entities/product_details.dart';
import '../../../domain/repositories/products_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository productRepository;

  Future<ProductDetails> fetchProductDetails({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      return await productRepository.fetchProductDetails(
        productId: productId,
        userId: userId,
        token: token,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Rating>> fetchProductRatings({
    required String token,
    required int productId,
  }) async {
    try {
      return await productRepository.fetchProductRatings(
        token: token,
        productId: productId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> rateProduct({
    required Rating rating,
    required String token,
  }) async {
    try {
      final response = await productRepository.rateProduct(rating, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeProductRating({
    required int productId,
    required int userId,
    required String token,
  }) async {
    try {
      return await productRepository.removeProductRating(
        productId: productId,
        userId: userId,
        token: token,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleFavorite({
    required int userId,
    required int productId,
    required String token,
  }) async {
    try {
      final request = await productRepository.toggleFavorite(
        productId: productId,
        userId: userId,
        token: token,
      );
      final response = request['message']['is_favorite'];
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ProductBloc(this.productRepository) : super(ProductInitial());
}
