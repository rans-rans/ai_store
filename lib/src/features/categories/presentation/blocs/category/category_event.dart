part of 'category_bloc.dart';

sealed class CategoryEvent {}

final class FetchAllCategories extends CategoryEvent {
  final String token;

  FetchAllCategories(this.token);
}
