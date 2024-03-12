part of 'products_bloc.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsError extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<Product> products;
  ProductsSuccess({required this.products});
}
