part of 'product_bloc.dart';

sealed class ProductEvent {}

final class ToggleProductFavorite extends ProductEvent {
  final String productId;
  final String userId;
  final bool value;

  ToggleProductFavorite({
    required this.productId,
    required this.userId,
    required this.value,
  });
}
