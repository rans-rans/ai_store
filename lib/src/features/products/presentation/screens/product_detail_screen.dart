import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/entities/product_details.dart';
import '../blocs/product/product_bloc.dart';
import '../widgets/description_body.dart';
import '../widgets/description_bottom_sheet.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final selectedVariation = ValueNotifier<String?>(null);

  late Future<ProductDetails> productFuture;
  late AuthUser authUser;

  @override
  void initState() {
    super.initState();
    authUser = context.read<AuthBloc>().user!;
    productFuture = context.read<ProductBloc>().fetchProductDetails(
          productId: widget.productId,
          userId: authUser.userId,
          token: authUser.authToken,
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productFuture,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          centerTitle: true,
        ),
        bottomSheet: DescriptionBottomSheet(
          snapshot: snapshot,
          selectedVariation: selectedVariation,
        ),
        body: Builder(builder: (context) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    productFuture = context.read<ProductBloc>().fetchProductDetails(
                          productId: widget.productId,
                          userId: authUser.userId,
                          token: authUser.authToken,
                        );
                  });
                },
                child: const Text('Reload'),
              ),
            );
          }
          return DescriptionBody(
            product: snapshot.data!,
            selectedVariation: selectedVariation,
          );
        }),
      ),
    );
  }
}
