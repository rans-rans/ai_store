import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class OnlineImage extends StatelessWidget {
  final String image;
  final double? height;
  const OnlineImage({required this.image, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      useOldImageOnUrlChange: true,
      height: height,
      memCacheHeight: 200,
      memCacheWidth: 200,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      progressIndicatorBuilder: (context, url, progress) {
        return const Center(child: Text("loading..."));
      },
      errorWidget: (context, url, error) {
        return Image.asset(errorFallbackImage);
      },
    );
  }
}
