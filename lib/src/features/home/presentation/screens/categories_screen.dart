import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../widgets/categories_list.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController heightAnimationController;
  late Animation<double> topContainerAnimation;

  late Size screenSize;

  final heightTransitionDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    heightAnimationController = AnimationController(
      vsync: this,
      duration: heightTransitionDuration,
    );
  }

  @override
  void dispose() {
    super.dispose();
    heightAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    topContainerAnimation = Tween(
      // 41 is just a lucky number i figured out from try and error. It works perfect for all screens
      // Don't tell me it's a hardcoded value
      begin: MediaQuery.paddingOf(context).top + 41,
      end: screenSize.height -
          (MediaQuery.paddingOf(context).bottom - kBottomNavigationBarHeight),
    ).animate(heightAnimationController);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: const CategoriesList(),
        ),
        AnimatedBuilder(
          animation: topContainerAnimation,
          builder: (context, child) {
            return Container(
              color: Colors.grey.shade200,
              height: topContainerAnimation.value,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.paddingOf(context).top),
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "AI STORE",
                        style: TextStyle(
                          fontSize: mediumFontSize,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          if (heightAnimationController.isCompleted) {
                            heightAnimationController.reverse();
                          } else {
                            heightAnimationController.forward();
                          }
                        },
                        child: const Icon(
                          Icons.menu,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  //TODO list of categories here
                  Expanded(
                    child: GridView.builder(
                      itemCount: 13,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 100,
                      ),
                      itemBuilder: (context, index) {
                        return const Card(
                          child: SizedBox(
                            height: 60,
                            child: Text("Home Applicances"),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
