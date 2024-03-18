part of 'cart_bloc.dart';

sealed class CartEvent {}

final class AddProductToCartEvent extends CartEvent {
  final CartItem cartItem;
  final String userId;

  AddProductToCartEvent({required this.cartItem, required this.userId});
}

final class RemoveProductFromCartEvent extends CartEvent {
  final String userId;
  final String productId;

  RemoveProductFromCartEvent({required this.userId, required this.productId});
}

final class IncrementItemQuantity extends CartEvent {
  final String userId;
  final String productId;

  IncrementItemQuantity({required this.userId, required this.productId});
}

final class DecrementItemQuantity extends CartEvent {
  final String userId;
  final String productId;

  DecrementItemQuantity({required this.userId, required this.productId});
}

final class UpdateUserCart extends CartEvent {
  final Cart cart;

  UpdateUserCart({required this.cart});
}
