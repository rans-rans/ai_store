import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';

import '../../../../constants/api_constants.dart';
import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../orders/domain/entities/express_order.dart';
import '../../../orders/domain/entities/order.dart';
import '../blocs/cubit/checkout_cubit.dart';
import '../widgets/checkout_item_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final selectedLocation = ValueNotifier<String?>(null);
  Order? order;
  late AuthUser user;
  late double totalCost;
  List<String> dropLocations = ['Bomso', 'Ayeduase', 'Kotei', 'Boadi', 'Ahinsan'];

  Future displayPaymentStatus(bool success) async {
    final size = MediaQuery.sizeOf(context);
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Center(
          child: Container(
            alignment: Alignment.center,
            width: size.width * 0.75,
            height: size.height * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  color: success ? Colors.green : Colors.red,
                  success ? Icons.check_circle : Icons.cancel_rounded,
                  size: 30,
                ),
                const SizedBox(width: 16),
                Text(success ? "Payment Successful" : "Payment unsuccessful")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    user = context.read<AuthBloc>().user!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
          style: TextStyle(fontWeight: mediumFontWeight),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartState = state as CartFetchSuccess;
          final cart = cartState.cart;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: DropdownMenu<String>(
                      label: const Text('location'),
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      onSelected: (value) {
                        selectedLocation.value = value;
                      },
                      dropdownMenuEntries: [
                        ...dropLocations.map(
                          (variant) => DropdownMenuEntry(
                            value: variant,
                            label: variant,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "Items",
                    style: TextStyle(
                      fontSize: mediumFontSize,
                      fontWeight: mediumFontWeight,
                    ),
                  ),
                  const SizedBox(
                    height: smallSpacing,
                  ),

                  Flexible(
                    child: ListView.builder(
                      itemCount: cart.products.length,
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cartItem = cart.products[index];
                        return CheckoutItemWidget(cartItem: cartItem, screenSize: screenSize);
                      },
                    ),
                  ),
                  const SizedBox(height: mediumSpacing),
                  const Text(
                    "Order Summary",
                    style: TextStyle(
                      fontWeight: mediumFontWeight,
                    ),
                  ),
                  const SizedBox(height: smallSpacing),
                  //cart summary over here
                  Table(
                    children: [
                      TableRow(
                        children: [
                          const Text("Items"),
                          Text(cart.products.length.toString()),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Drop Location"),
                          ValueListenableBuilder(
                            valueListenable: selectedLocation,
                            builder: (context, value, child) =>
                                Text(value ?? "No location selected"),
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Total cost"),
                          FutureBuilder(
                            initialData: 0.0,
                            future: HelperFunctions.getCartTotalPrice(cart.products),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Text("Calculating");
                              }
                              return Text(
                                HelperFunctions.formatToCurrency(snapshot.data!),
                                style: const TextStyle(
                                  fontWeight: mediumFontWeight,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: mediumSpacing * 2.5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(buttonBorderRadius),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          if (selectedLocation.value == null) {
                            HelperFunctions.snackShow(context, "Please select a location");
                            return;
                          }
                          order = ExpressOrder(
                            customerName: user.username ?? user.email.split('@')[0],
                            userId: user.userId,
                            deliveryLocation: selectedLocation.value!,
                            orderDate: DateTime.now(),
                            cart: cart,
                            totalCost: totalCost,
                          );
                          final initializedResponse =
                              await context.read<CheckoutCubit>().initializePayment(
                                    cart: order!,
                                    email: user.email,
                                  );

                          if (context.mounted) {
                            PaymentService.showPaymentModal(
                              context,
                              callbackUrl: '',
                              transaction: PaystackInitializedTraction(
                                status: initializedResponse['status'],
                                message: initializedResponse['message'],
                                data: PaystackInitializedTractionData(
                                  authorizationUrl: initializedResponse['data']
                                      ['authorization_url'],
                                  accessCode: initializedResponse['data']['access_code'],
                                  reference: initializedResponse['data']['reference'],
                                ),
                              ),
                            ).then((value) async {
                              final transactionVerified =
                                  await context.read<CheckoutCubit>().verifyTransaction(
                                        key: secrectKey,
                                        ref: initializedResponse['data']['reference'],
                                      );
                              displayPaymentStatus(transactionVerified).then((value) {
                                if (mounted) {
                                  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName('/'),
                                  );
                                  context.read<CartBloc>().add(ClearCart());
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            });
                          }
                        } catch (e) {
                          rethrow;
                        }
                      },
                      child: FutureBuilder(
                          future: HelperFunctions.getCartTotalPrice(cart.products),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("...");
                            }
                            totalCost = snapshot.data!;
                            return RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Checkout for ",
                                  ),
                                  TextSpan(
                                    text:
                                        HelperFunctions.formatToCurrency(snapshot.requireData),
                                    style: const TextStyle(
                                      fontWeight: boldestFontWeight,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
