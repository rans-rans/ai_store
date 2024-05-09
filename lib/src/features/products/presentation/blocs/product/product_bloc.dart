import 'package:flutter_bloc/flutter_bloc.dart';

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
