import 'package:cloud_firestore/cloud_firestore.dart';

import 'products_datasource.dart';

class FirebaseDataSource implements ProductsDataSource {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addToCart(String productId) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> fetchGeneralProducts() async {
    try {
      final response = await db.collection("products").limit(100).snapshots().first;
      final docList = response.docs.map((event) {
        return event.data();
      }).toList();
      return docList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rateProduct(String productId) {
    // TODO: implement rateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> removeSavedProduct(String productId) {
    // TODO: implement removeSavedProduct
    throw UnimplementedError();
  }

  @override
  Future<void> saveProduct(String productId) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(
      {required String userId,
      required String productId,
      required bool value}) async {
    try {
      return await db
          .collection('products')
          .doc(productId)
          .collection('favorites')
          .doc(userId)
          .set(
        {'is_favorite': value},
        SetOptions(merge: true),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<bool> listenToFavoriteStatus({
    required String productId,
    required String userId,
  }) {
    return db
        .collection('products')
        .doc(productId)
        .collection('favorites')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final isFavorite = (snapshot.data()?["is_favorite"] ?? false) as bool;
      return isFavorite;
    });
  }
}
