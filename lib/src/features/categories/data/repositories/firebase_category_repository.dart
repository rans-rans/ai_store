import '../../domain/entities/brand.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/firebase_brand.dart';
import '../../domain/entities/firebase_category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_datasource.dart';

class FirebaseCategoryRepository implements CategoryRepository {
  final CategoryDatasource categoryDatasource;

  FirebaseCategoryRepository({required this.categoryDatasource});
  @override
  Future<List<Brand>> fetchAllBrands() async {
    try {
      final request = await categoryDatasource.fetchAllBrands();
      final response = request.map(FirebaseBrand.fromStorage).toList();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> fetchAllCategories() async {
    try {
      final request = await categoryDatasource.fetchAllCategories();
      final response = request.map(FirebaseCategory.fromStorage).toList();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
