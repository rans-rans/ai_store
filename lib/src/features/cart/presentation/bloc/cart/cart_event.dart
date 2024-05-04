part of 'cart_bloc.dart';

sealed class CartEvent {}

final class GetUserCart extends CartEvent {
  final int userId;

  GetUserCart({required this.userId});
}

final class AddProductToCartEvent extends CartEvent {
  final CartItem cartItem;

  AddProductToCartEvent({required this.cartItem});
}

final class ChangeItemQuantityEvent extends CartEvent {
  final int userId;
  final int quantity;
  final int productId;

  ChangeItemQuantityEvent({
    required this.userId,
    required this.quantity,
    required this.productId,
  });
}
