import '../entities/brand.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Brand>> fetchAllBrands(
    String token,
  );
  Future<List<Category>> fetchAllCategories(
    String token,
  );
}
