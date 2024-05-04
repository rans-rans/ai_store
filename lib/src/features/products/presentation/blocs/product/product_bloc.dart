import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  Future<bool> toggleFavorite({
    required int userId,
    required int productId,
  }) async {
    try {
      final request = await productRepository.toggleFavorite(
        productId: productId,
        userId: userId,
      );
      final response = request['message']['is_favorite'];
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ProductBloc(this.productRepository) : super(ProductInitial());
}
