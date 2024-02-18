import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../widgets/image_carousel.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //TODO add sharing logic here
            },
            icon: const Icon(Icons.share),
          ),
          PopupMenuButton(
            tooltip: "more",
            offset: const Offset(0, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardBorderRadius)),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add wishlist logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.star),
                      Text("My Favorites"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add wishlist logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.download),
                      Text("Save to wishlist"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add watch logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.visibility),
                      Text("Watch this item"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add report logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.report),
                      Text("Report"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 85,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //TODO actual price over here
                    const Text(
                      "₵ 640.00",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        //TODO discount percent over here
                        child: Text("-22%"),
                      ),
                    ),
                  ],
                ),
                //TODO discount price over here
                const Text(
                  "₵ 500.00",
                  style: TextStyle(
                    fontWeight: mediumFontWeight,
                    fontSize: largeFontSize,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(screenSize.width * 0.4, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                ),
              ),
              child: const Text("ADD TO CART"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const ImageCarousel(),
                Positioned(
                  right: screenSize.width * 0.05,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      //TODO toggle isFavorite here
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 40,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: smallSpacing),
            //TODO  item  name comes here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PS5 Controller Charger Playstation 5 Dualsense Charging Station Dock Mount For Dual Playstation 5 Controllers With LED Indicator",
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                    style: TextStyle(
                      fontWeight: mediumFontWeight,
                    ),
                  ),
                  const SizedBox(height: smallSpacing),
                  //TODO add a readmore widget here
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "New White color ps5 remote control gamepad PC, android LED light game joystick wireless games controller for ps5",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: smallSpacing),
                  //TODO add functionality to rating stars
                  Row(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        "531 ratings",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: mediumSpacing),
                  Align(
                    alignment: Alignment.center,
                    child: DropdownMenu(
                      label: const Text("Select variant"),
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      onSelected: (value) {
                        //TODO selected variant logic
                      },
                      //TODO the list of variants come here
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: "value",
                          label: "label",
                        ),
                        DropdownMenuEntry(
                          value: "value",
                          label: "label 2",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: mediumSpacing * 2.5),
                  const Text(
                    "About this item",
                    style: TextStyle(
                      fontWeight: mediumFontWeight,
                      fontSize: mediumFontSize,
                    ),
                  ),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.4),
                      1: FlexColumnWidth(0.6),
                    },
                    children: const [
                      TableRow(
                        children: [
                          Text("Condition"),
                          Text("New"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("Quanntity status"),
                          Text("Plenty"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("Brand"),
                          Text("Sony"),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text("Type"),
                          Text("Controller"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
