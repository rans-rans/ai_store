import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;

import '../../../../utils/helper_functions.dart';
import 'category_datasource.dart';

class FirebaseCategoryDatasource implements CategoryDatasource {
  final db = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> fetchAllBrands() async {
    try {
      final response = await db.collection('brands').snapshots().first;
      final docList = HelperFunctions.getDocumentList(response);
      return docList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllCategories() async {
    try {
      final response = await db.collection('categories').snapshots().first;
      final docList = HelperFunctions.getDocumentList(response);
      return docList;
    } catch (e) {
      rethrow;
    }
  }
}
