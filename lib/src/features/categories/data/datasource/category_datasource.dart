abstract class CategoryDatasource {
  Future<List<dynamic>> fetchAllBrands(
    String token,
  );
  Future<List<dynamic>> fetchAllCategories(
    String token,
  );
}
