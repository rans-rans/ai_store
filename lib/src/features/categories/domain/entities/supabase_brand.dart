import 'brand.dart';

class SupabaseBrand extends Brand {
  SupabaseBrand({required super.id, required super.name, required super.image});

  factory SupabaseBrand.fromStorage(Map<String, dynamic> data) {
    return SupabaseBrand(
      id: data['brand_id'],
      name: data['name'],
      image: data['image_url'],
    );
  }
}
