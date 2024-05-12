part of 'orders_bloc.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrderFetchLoading extends OrdersState {}

final class OrderFetchFailed extends OrdersState {
  final String message;

  OrderFetchFailed({required this.message});
}

final class OrderFetchSuccess extends OrdersState {
  final List<Order> orders;

  OrderFetchSuccess({required this.orders});
}
