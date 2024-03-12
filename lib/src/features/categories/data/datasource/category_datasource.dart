abstract class CategoryDatasource {
  Future<List<Map<String, dynamic>>> fetchAllBrands();
  Future<List<Map<String, dynamic>>> fetchAllCategories();
}
