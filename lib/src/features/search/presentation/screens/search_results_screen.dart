import 'package:flutter/material.dart';

import '../widgets/search_result_tile.dart';
import '../widgets/show_sort_filer_drawer.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        //TODO the search term comes here
        title: const Text("fridge"),
        actions: [
          IconButton(
            onPressed: () {
              //TODO add sorting logic here
            },
            icon: const Icon(Icons.sort),
            tooltip: "sort",
          ),
          IconButton(
            onPressed: () {
              //TODO add sorting logic here
            },
            icon: const Icon(Icons.filter_alt),
            tooltip: "filter",
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Column(
            children: [
              //TODO  list of results below
              SearchResultTile(),
            ],
          ),
          ShowSortFilterDrawer(screenSize: screenSize)
        ],
      ),
    );
  }
}
