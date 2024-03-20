import '../../../../constants/objects.dart';
import 'category_datasource.dart';

class SupabaseCategoryDatasource implements CategoryDatasource {
  @override
  Future<List<Map<String, dynamic>>> fetchAllBrands() async {
    try {
      final request = await supabaseInstance.from('brands').select();
      return request;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAllCategories() async {
    try {
      final request = await supabaseInstance.from('categories').select();
      return request;
    } catch (e) {
      rethrow;
    }
  }
}
