part of 'cart_bloc.dart';

sealed class CartEvent {}

final class ClearCart extends CartEvent {}

final class GetUserCart extends CartEvent {
  final int userId;
  final String token;

  GetUserCart({
    required this.userId,
    required this.token,
  });
}

final class AddProductToCartEvent extends CartEvent {
  final CartItem cartItem;
  final String token;

  AddProductToCartEvent({required this.cartItem, required this.token});
}

final class ChangeItemQuantityEvent extends CartEvent {
  final int userId;
  final int quantity;
  final int productId;
  final String token;

  ChangeItemQuantityEvent({
    required this.userId,
    required this.quantity,
    required this.productId,
    required this.token,
  });
}
