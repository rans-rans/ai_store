import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/numbers.dart';
import '../../data/data_source/products_datasource.dart';

class RatingTile extends StatelessWidget {
  final Rating rating;
  const RatingTile({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: mediumSpacing),
          Text(rating.comment),
          Row(
            children: [
              RatingBarIndicator(
                itemSize: 20,
                rating: rating.score.toDouble(),
                itemBuilder: (context, index) {
                  return const Icon(Icons.star);
                },
              ),
              const SizedBox(width: smallSpacing),
              Text(
                DateTime.parse(rating.dateCreated)
                    .format(DateTimeFormats.europeanAbbr),
              ),
            ],
          ),
          const SizedBox(height: smallSpacing),
        ],
      ),
    );
  }
}
