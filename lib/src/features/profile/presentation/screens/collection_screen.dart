import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/segment_control/segment_control_cubit.dart';
import '../widgets/collection_following_list.dart';
import '../widgets/collection_saved_list.dart';
import '../widgets/collection_wishlist_list.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collections"),
      ),
      body: BlocBuilder<CollectionsSegmentControl, int>(
        builder: (context, state) {
          return Column(
            children: [
              CupertinoSlidingSegmentedControl<int>(
                groupValue: state,
                children: const {
                  0: SegmentButton(label: "Saved"),
                  1: SegmentButton(label: "Wishlist"),
                  2: SegmentButton(label: "following"),
                },
                onValueChanged: (value) {
                  if (state == value) return;
                  pageController.jumpToPage(value!);
                  context.read<CollectionsSegmentControl>().changeSegment(value);
                },
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    context.read<CollectionsSegmentControl>().changeSegment(value);
                  },
                  children: const [
                    CollectionSavedList(),
                    CollectionWishlistList(),
                    CollectionFollowingList(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SegmentButton extends StatelessWidget {
  const SegmentButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      width: screenSize.width * 0.3,
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
