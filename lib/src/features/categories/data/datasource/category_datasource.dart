abstract class CategoryDatasource {
  Future<List<Map<String, dynamic>>> fetchAllBrands(
    String token,
  );
  Future<List<Map<String, dynamic>>> fetchAllCategories(
    String token,
  );
}
