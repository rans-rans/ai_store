import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/entities/order.dart';
import '../blocs/order_bloc/orders_bloc.dart';
import '../widgets/orders_list_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late AuthUser user;
  @override
  void initState() {
    super.initState();
    user = context.read<AuthBloc>().user!;
    context.read<OrdersBloc>().add(
          FetchUserOrdersEvent(
            userId: user.userId,
            token: user.authToken,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Text("Pending"),
              Text("Delivered"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrderFetchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrdersInitial || state is OrderFetchFailed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Orders Unavailable"),
                      ElevatedButton(
                        onPressed: () {
                          context.read<OrdersBloc>().add(
                                FetchUserOrdersEvent(
                                  userId: user.userId,
                                  token: user.authToken,
                                ),
                              );
                        },
                        child: const Text("Reload"),
                      ),
                    ],
                  ),
                );
              }
              final newState = state as OrderFetchSuccess;
              final orders = newState.orders;
              final pendings = orders
                  .where((element) => element.status == OrderStatus.pending)
                  .toList();
              final delivered = orders
                  .where((element) => element.status == OrderStatus.delivered)
                  .toList();

              return TabBarView(
                children: [
                  OrdersListWidget(orders: pendings),
                  OrdersListWidget(orders: delivered),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
