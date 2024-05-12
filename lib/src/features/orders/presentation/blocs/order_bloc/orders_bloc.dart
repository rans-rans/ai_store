import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/order.dart';
import '../../../domain/repositories/order_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepo orderRepo;
  OrdersBloc({required this.orderRepo}) : super(OrdersInitial()) {
    on<FetchUserOrdersEvent>((event, emit) async {
      try {
        emit(OrderFetchLoading());
        final orders = await orderRepo.fetchUserOrders(
          userId: event.userId,
          token: event.token,
        );
        emit(OrderFetchSuccess(orders: orders));
      } catch (e) {
        emit(OrderFetchFailed(message: e.toString()));
      }
    });
  }
}
