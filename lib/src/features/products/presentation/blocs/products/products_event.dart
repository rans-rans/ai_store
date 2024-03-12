part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class FetchProducts extends ProductsEvent {}

final class FetchProductsByBrand extends ProductsEvent {
  final String brandName;
  FetchProductsByBrand({required this.brandName});
}

final class FetchProductsByCategory extends ProductsEvent {
  final String categoryId;
  FetchProductsByCategory({required this.categoryId});
}
