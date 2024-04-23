import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';

import '../../../../constants/api_constants.dart';
import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../cart/domain/entities/cart.dart';
import '../../../orders/domain/entities/order.dart';
import '../../../orders/domain/entities/supabase_order.dart';
import '../../domain/entities/metadata.dart';
import '../blocs/cubit/checkout_cubit.dart';
import '../widgets/checkout_item_widget.dart';

class CheckoutScreen extends StatefulWidget {
  final Cart cart;
  const CheckoutScreen({super.key, required this.cart});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final selectedLocation = ValueNotifier<String?>(null);
  Order? order;
  List<String> dropLocations = ['Bomso', 'Ayeduase', 'Kotei', 'Boadi', 'Ahinsan'];

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
      body: SingleChildScrollView(
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
                  itemCount: widget.cart.products.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cartItem = widget.cart.products[index];
                    return CheckoutItemWidget(
                        cartItem: cartItem, screenSize: screenSize);
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
                      Text(widget.cart.products.length.toString()),
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
                        future:
                            HelperFunctions.getCartTotalPrice(widget.cart.products),
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
                      final cartData =
                          widget.cart.products.map((e) => e.toServer()).toList();
                      //TODO use dynamic values
                      final metaData = Metadata(
                        userId: dummyUserId,
                        customerName: 'Ransford Owusu-Ansah',
                        phone: '0559529436',
                        cartData: cartData,
                        email: 'ransfordowusuansah9@gmail.com',
                      );
                      //TODO handle payment sucess and failure
                      if (selectedLocation.value == null) {
                        HelperFunctions.snackShow(
                            context, "Please select a location");
                        return;
                      }
                      order = SupabaseOrder(
                        orderId: DateTime.now().toString(),
                        userId: dummyUserId,
                        deliveryLocation: selectedLocation.value!,
                        orderDate: DateTime.now(),
                        cart: widget.cart,
                      );
                      final initializedResponse =
                          await context.read<CheckoutCubit>().initializePayment(
                                cart: order!,
                                metadata: metaData,
                              );

                      print('initialized  response  is  $initializedResponse');
                      if (mounted) {
                        PaymentService.showPaymentModal(
                          context,
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
                          final verifyResponse =
                              await context.read<CheckoutCubit>().verifyTransaction(
                                    key: secrectKey,
                                    ref: initializedResponse['data']['reference'],
                                  );
                          print(verifyResponse);
                        });
                      }
                    } catch (e) {
                      rethrow;
                    }
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Checkout for ",
                        ),
                        TextSpan(
                          text: HelperFunctions.formatToCurrency(5
                              // getTotalAmount(widget.cart.products),
                              ),
                          style: const TextStyle(
                            fontWeight: boldestFontWeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}