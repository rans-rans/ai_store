part of 'product_bloc.dart';

sealed class ProductEvent {}

final class ToggleProductFavorite extends ProductEvent {
  final int productId;
  final int userId;
  ToggleProductFavorite({
    required this.productId,
    required this.userId,
  });
}
