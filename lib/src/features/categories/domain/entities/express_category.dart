import 'category.dart';

class ExpressCategory extends Category {
  ExpressCategory({required super.id, required super.name, required super.image});

  factory ExpressCategory.fromServer(dynamic data) {
    return ExpressCategory(
      id: data['id'],
      name: data['name'],
      image: data['image_url'],
    );
  }
}
