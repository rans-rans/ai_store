import 'category.dart';

class FirebaseCategory extends Category {
  FirebaseCategory({required super.id, required super.name, required super.image});

  factory FirebaseCategory.fromStorage(Map<String, dynamic> map) {
    return FirebaseCategory(
      id: map['id'],
      name: map['name'],
      image: map['img_tag'],
    );
  }
}
