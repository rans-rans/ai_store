import '../../domain/entities/brand.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/supabase_brand.dart';
import '../../domain/entities/supabase_category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_datasource.dart';

class SupabaseCategoryRepository implements CategoryRepository {
  final CategoryDatasource categoryDatasource;

  SupabaseCategoryRepository({required this.categoryDatasource});
  @override
  Future<List<Brand>> fetchAllBrands() async {
    try {
      final request = await categoryDatasource.fetchAllBrands();
      final response = request.map(SupabaseBrand.fromStorage);
      return response.toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> fetchAllCategories() async {
    try {
      final request = await categoryDatasource.fetchAllCategories();
      final response = request.map(SupabaseCategory.fromStorage);
      return response.toList();
    } catch (e) {
      rethrow;
    }
  }
}
