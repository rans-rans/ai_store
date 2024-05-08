import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ItemDescriptionWidget extends StatelessWidget {
  const ItemDescriptionWidget({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReadMoreText(
        description,
        trimLines: 2,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: ' ...Show less',
        lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
        moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
