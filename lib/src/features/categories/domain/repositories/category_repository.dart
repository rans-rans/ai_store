import '../entities/brand.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Brand>> fetchAllBrands();
  Future<List<Category>> fetchAllCategories();
}
