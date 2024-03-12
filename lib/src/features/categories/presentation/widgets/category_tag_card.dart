import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';

class CategoryTagCard extends StatelessWidget {
  const CategoryTagCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: SizedBox(
          height: 60,
          child: Center(child: Text(category.name)),
        ),
      ),
    );
  }
}
