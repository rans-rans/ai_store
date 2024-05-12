part of 'orders_bloc.dart';

sealed class OrdersEvent {}

final class FetchUserOrdersEvent extends OrdersEvent {
  final int userId;
  final String token;

  FetchUserOrdersEvent({required this.userId, required this.token});
}
