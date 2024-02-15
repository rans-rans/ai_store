import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';
import 'categories_just_for_you_widget.dart';
import 'limited_timed_deals_widget.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 41),
          //TODO  category name comes here
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Clothing and Aparel",
              style: TextStyle(fontSize: mediumFontSize),
            ),
          ),
          const SizedBox(height: mediumSpacing * 2),
          //TODO  sub-categories comes here
          SizedBox(
            height: screenSize.height * 0.2,
            child: GridView.builder(
              itemCount: 13,
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                //TODO it should have a tap event
                return const CircleAvatar(
                  backgroundImage: AssetImage(
                    onboardingBackgroundImage,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: mediumSpacing * 3),
          const Text(
            "Limited time deals",
            style: TextStyle(
              fontSize: mediumFontSize,
              fontWeight: mediumFontWeight,
            ),
          ),
          //TODO limited time deals comes here
          SizedBox(
            height: screenSize.height * 0.27,
            child: ListView.builder(
              itemCount: 12,
              itemExtent: screenSize.width * 0.42,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const LimitedTimeDealsWidget();
              },
            ),
          ),
          const SizedBox(height: mediumSpacing),
          const Text(
            "Just for you",
            style: TextStyle(
              fontWeight: mediumFontWeight,
              fontSize: mediumFontSize,
            ),
          ),
          GridView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
                crossAxisSpacing: screenSize.width * 0.05),
            itemBuilder: (context, index) {
              return const CategoriesJustForYouWidget();
            },
          ),
        ],
      ),
    );
  }
}
