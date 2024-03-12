import 'brand.dart';

class FirebaseBrand extends Brand {
  FirebaseBrand({required super.id, required super.name, required super.image});

  factory FirebaseBrand.fromStorage(Map<String, dynamic> map) {
    return FirebaseBrand(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}
