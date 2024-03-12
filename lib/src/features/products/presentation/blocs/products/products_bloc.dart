import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _productsRepository;

  ProductsBloc(this._productsRepository) : super(ProductsInitial()) {
    on<GetProducts>((event, emit) async {
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
