class Product {
  final String name;
  final String brand;
  final String id;
  final String category;
  final String description;
  final double discount;
  final List<dynamic> images;
  final double price;
  final List<dynamic> subCategories;
  final List<dynamic> variants;
  Product({
    required this.name,
    required this.brand,
    required this.variants,
    required this.id,
    required this.category,
    required this.description,
    required this.discount,
    required this.images,
    required this.price,
    required this.subCategories,
  });
}
