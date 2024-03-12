part of 'category_bloc.dart';

sealed class CategoryState {}

final class CategoriesInitial extends CategoryState {}

final class CategoriesFetchLoading extends CategoryState {}

final class CategoriesFetchFailed extends CategoryState {}

final class CategoriesFetchSuccess extends CategoryState {
  final List<Category> categories;

  CategoriesFetchSuccess({required this.categories});
}
