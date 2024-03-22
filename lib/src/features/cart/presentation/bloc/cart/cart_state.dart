part of 'cart_bloc.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartFetchLoading extends CartState {}

final class CartFetchFailed extends CartState {}

final class CartFetchSuccess extends CartState {
  final Cart cart;

  CartFetchSuccess({required this.cart});
}
