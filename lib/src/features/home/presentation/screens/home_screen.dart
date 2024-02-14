import 'package:flutter/material.dart';

import '/src/features/home/presentation/widgets/spaced_row_widget.dart';
import '../../../../constants/numbers.dart'
    show
        cardBorderRadius,
        defaultPadding,
        mediumFontSize,
        mediumFontWeight,
        mediumSpacing,
        smallSpacing;
import '../widgets/popular_card_widget.dart';
import '../widgets/recent_activity_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 40,
        title: const Text("AI STORE"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: GestureDetector(
            onTap: () {
              //TODO  navigate to search
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: const EdgeInsets.all(3),
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                ),
                child: const Row(
                  children: [
                    Text("Search"),
                    Spacer(),
                    Icon(
                      Icons.camera_enhance_outlined,
                      size: 25,
                    ),
                    SizedBox(width: smallSpacing),
                    Icon(
                      Icons.search,
                      size: 25,
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
