import 'category.dart';

class SupabaseCategory extends Category {
  SupabaseCategory({required super.id, required super.name, required super.image});

  factory SupabaseCategory.fromStorage(Map<String, dynamic> data) {
    return SupabaseCategory(
      id: data['category_id'],
      name: data['name'],
      image: data['image_url'],
    );
  }
}
