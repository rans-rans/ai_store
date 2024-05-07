import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productsRepository;

  Future<List<Product>> fetchProductsByBrand(
    int brandId,
    int userId,
    String token,
  ) async {
    try {
      final response = await _productsRepository.fetchProductsByBrand(
        brandID: brandId,
        userId: userId,
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> fetchProductsByCategory(
    int categoryId,
    int userId,
    String token,
  ) async {
    try {
      final response = await _productsRepository.fetchProductsByCategory(
        categoryId: categoryId,
        userId: userId,
        token: token,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  ProductsBloc(this._productsRepository) : super(ProductsInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await _productsRepository
            .fetchProducts(event.userId, event.token)
            .timeout(const Duration(seconds: 7));
        emit(ProductsSuccess(products: products));
      } catch (e) {
        emit(ProductsError());
      }
    });
  }
}
