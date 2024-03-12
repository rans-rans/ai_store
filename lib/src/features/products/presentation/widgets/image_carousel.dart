import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../constants/strings.dart' show errorFallbackImage;

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
              return CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(child: Text("loading..."));
                },
                errorWidget: (context, url, error) {
                  return Image.asset(errorFallbackImage);
                },
              );
            })
          ],
        ),
      ],
    );
  }
}
