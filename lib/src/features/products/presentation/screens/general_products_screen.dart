import 'package:flutter/material.dart';

import '../../../search/presentation/screens/open_camera_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '/src/features/home/presentation/widgets/spaced_row_widget.dart';
import '../../../../constants/numbers.dart'
    show
        cardBorderRadius,
        defaultPadding,
        mediumFontSize,
        mediumFontWeight,
        mediumSpacing,
        smallSpacing;
import '../../../home/presentation/widgets/popular_card_widget.dart';
import '../../../home/presentation/widgets/recent_activity_card.dart';

class GeneralProductsScreen extends StatelessWidget {
  const GeneralProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 40,
        title: const Text("AI STORE"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: GestureDetector(
            onTap: () {
              //TODO navigate to search screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const SearchScreen();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                ),
                child: Row(
                  children: [
                    const Text("Search"),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.camera_enhance_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const OpenCameraScreen();
                            },
                          ),
                        );
                      },
                      iconSize: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                ),
                child: const Placeholder(),
              ),
              //TODO  add carousel dots
              const SizedBox(height: mediumSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontWeight: mediumFontWeight,
                      fontSize: mediumFontSize,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      //TODO  navigate to popular screen
                    },
                  ),
                ],
              ),
              const SizedBox(height: smallSpacing),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PopularCardWidget(),
                    PopularCardWidget(),
                    PopularCardWidget(),
                    PopularCardWidget(),
                    PopularCardWidget(),
                  ],
                ).withSpacing(axis: Axis.horizontal),
              ),
              const SizedBox(height: mediumSpacing),
              const Text(
                "Based on Recent Activity",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                ),
              ),
              GridView.builder(
                primary: false,
                itemCount: 7,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: size.width * 0.05,
                ),
                itemBuilder: (context, index) {
                  return const RecentActivityCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
