import 'package:ai_store/src/widgets/online_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<dynamic> imagePaths;
  const ImageCarousel({
    super.key,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1,
            height: screenSize.height * 0.45,
            aspectRatio: 1,
          ),
          carouselController: CarouselController(),
          items: [
            ...imagePaths.map((image) {
              return OnlineImage(image: image);
            })
          ],
        ),
      ],
    );
  }
}
