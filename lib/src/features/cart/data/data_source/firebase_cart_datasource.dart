import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/helper_functions.dart';
import '../../domain/entities/cart.dart';
import 'cart_datasource.dart';

class FirebaseCartDatasource implements CartDatasource {
  final db = FirebaseFirestore.instance;
  @override
  Future<void> addProductToCart({
    required CartItem cartItem,
    required String userId,
  }) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartItem.productId)
          .set(cartItem.toServer());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> incrementItemQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .update({'quantity': FieldValue.increment(1)});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> decrementItemQuantity({
    required String productId,
    required String userId,
  }) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .update({'quantity': FieldValue.increment(-1)});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> fetchUserCart({
    required String userId,
  }) {
    try {
      return db
          .collection('users')
          .doc(userId)
          .collection('cart')
          .snapshots()
          .map((event) {
        final response = HelperFunctions.getDocumentList(event);
        return response;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeProductFromCart({
    required String productId,
    required String userId,
  }) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
