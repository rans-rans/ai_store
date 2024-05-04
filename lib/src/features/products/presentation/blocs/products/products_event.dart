part of 'products_bloc.dart';

sealed class ProductsEvent {}

final class FetchProducts extends ProductsEvent {
  final int userId;
  FetchProducts({required this.userId});
}

final class FetchProductsByBrand extends ProductsEvent {
  final int brandId;
  FetchProductsByBrand({required this.brandId});
}

final class FetchProductsByCategory extends ProductsEvent {
  final int categoryId;
  FetchProductsByCategory({required this.categoryId});
}
