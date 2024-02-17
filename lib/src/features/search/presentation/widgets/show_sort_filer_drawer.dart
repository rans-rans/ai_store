import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';

class ShowSortFilterDrawer extends StatelessWidget {
  const ShowSortFilterDrawer({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: screenSize.height * 0.025,
      child: InkWell(
        onTap: () {
          //TODO show sort and  filter drawer
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: screenSize.width * 0.35,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(cardBorderRadius),
          ),
          child: const Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("sort"),
                Icon(Icons.sort),
                SizedBox(width: 2),
                Text("|"),
                SizedBox(width: 2),
                Text("filter"),
                Icon(Icons.filter_alt),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
