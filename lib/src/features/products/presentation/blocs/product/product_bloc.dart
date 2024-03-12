import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  Stream<bool> listenToFavoriteStatus({
    required String userId,
    required String productId,
  }) {
    return _productRepository.listenToFavoriteStatus(
      productId: productId,
      userId: userId,
    );
  }

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<ToggleProductFavorite>((event, emit) {
      _productRepository.toggleFavorite(
        productId: event.productId,
        userId: event.userId,
        value: event.value,
      );
    });
  }
}
