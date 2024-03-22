part of 'cart_bloc.dart';

sealed class CartEvent {}

// final class AddProductToCartEvent extends CartEvent {
//   final CartItem cartItem;
//   final String userId;

//   AddProductToCartEvent({required this.cartItem, required this.userId});
// }

// final class RemoveProductFromCartEvent extends CartEvent {
//   final String userId;
//   final String productId;

//   RemoveProductFromCartEvent({required this.userId, required this.productId});
// }

final class ChangeItemQuantityEvent extends CartEvent {
  final String userId;
  final int quantity;
  final String productId;

  ChangeItemQuantityEvent({
    required this.userId,
    required this.quantity,
    required this.productId,
  });
}

final class UpdateUserCartEvent extends CartEvent {
  final Cart cart;

  UpdateUserCartEvent({required this.cart});
}
