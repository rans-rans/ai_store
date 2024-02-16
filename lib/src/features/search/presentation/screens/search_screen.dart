import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import 'open_camera_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: searchController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: "Search in store",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(inputBorderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(inputBorderRadius),
              ),
            ),
            onChanged: (value) {
              //TODO handle realtime search results here
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const OpenCameraScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.camera_enhance_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "clear",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Recents",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                  fontSize: mediumFontSize,
                ),
              ),
            ),
            //TODO list of recent searches comes here
            ListTile(
              title: const Text("games"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("shoes"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
