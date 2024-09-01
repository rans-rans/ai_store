import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../constants/api_constants.dart';
import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../products/domain/entities/express_product.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';
import 'open_camera_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  final searchResults = ValueNotifier(<Product>[]);

  late io.Socket socket;
  final dataLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    socket = io.io(
        baseUrl,
        io.OptionBuilder()
            .enableAutoConnect()
            .enableReconnection()
            .setTransports(['websocket']).build());

    socket.on('sr', (value) {
      final results = (value as List<dynamic>).map(ExpressProduct.fromServer);
      searchResults.value = results.toList();
      dataLoading.value = false;
    });

    searchController.addListener(searchInputListener);
  }

  void searchInputListener() {
    if (searchController.text.isEmpty) {
      dataLoading.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(searchInputListener);
    searchController.dispose();
    searchFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 55,
          child: ValueListenableBuilder(
              valueListenable: dataLoading,
              builder: (context, loading, child) {
                return TextField(
                  controller: searchController,
                  focusNode: searchFocus,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    suffix: switch (loading) {
                      false => null,
                      true => const SizedBox(
                          height: 10,
                          width: 15,
                          child: CircularProgressIndicator(),
                        ),
                    },
                    hintText: "Search in store",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(inputBorderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(inputBorderRadius),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      searchResults.value = [];
                      return;
                    }
                    dataLoading.value = true;
                    socket.emit('search', value);
                  },
                );
              }),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OpenCameraScreen(),
                ),
              );
            },
            icon: const Icon(Icons.camera_enhance_outlined),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: searchResults,
        child: const Center(
          child: Text('Search empty'),
        ),
        builder: (context, products, child) {
          if (products.isEmpty) return child!;
          return ListView.builder(
            itemCount: searchResults.value.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  searchFocus.unfocus();
                  HelperFunctions.gotoPage(
                    context: context,
                    page: ProductDetailScreen(productId: product.productId),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
