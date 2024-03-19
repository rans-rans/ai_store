import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productsRepository;

  Future<List<Product>> fetchProductsByBrand(String brandName) async {
    try {
      final response =
          await _productsRepository.fetchProductsByBrand(brandID: brandName);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      final response =
          await _productsRepository.fetchProductsByCategory(categoryId: categoryId);
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
            .fetchProducts()
            .timeout(const Duration(seconds: 7));
        emit(ProductsSuccess(products: products));
      } catch (e) {
        emit(ProductsError());
      }
    });
  }
}
