import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        //TODO navigate to item detail page
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: Image.asset(
                    fridgeImage,
                    width: screenSize.width * 0.5,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //TODO toggle is favorite here
                  },
                  child: const Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: Icon(
                        Icons.favorite_border,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: smallSpacing),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: smallSpacing),
                  //TODO  search item name here
                  Text(
                    "Double door refrigerator with android OS",
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: mediumFontWeight,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //TODO small description of item
                  Text(
                    "very brand new - samsung",
                    style: TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                  SizedBox(height: smallSpacing),
                  //TODO item price comes here
                  Text(
                    "GH₵ 4080.00",
                    style: TextStyle(fontWeight: mediumFontWeight),
                  ),
                  //TODO if item is on promotion
                  Text(
                    "GH₵ 4500.00 • 10% off",
                    style: TextStyle(
                      fontSize: smallFontSize,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
