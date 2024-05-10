import 'brand.dart';

class ExpressBrand extends Brand {
  ExpressBrand({required super.id, required super.name, required super.image});

  factory ExpressBrand.fromServer(dynamic data) {
    return ExpressBrand(
      id: data['id'],
      name: data['name'],
      image: data['image_url'],
    );
  }
}
