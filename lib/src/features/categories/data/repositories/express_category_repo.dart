import '../../domain/entities/brand.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/express_brand.dart';
import '../../domain/entities/express_category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_datasource.dart';

class ExpressCategoryRepo implements CategoryRepository {
  final CategoryDatasource datasource;

  ExpressCategoryRepo({required this.datasource});

  @override
  Future<List<Brand>> fetchAllBrands(String token) async {
    try {
      final request = await datasource.fetchAllBrands(token);
      final response = request.map(ExpressBrand.fromStorage).toList();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> fetchAllCategories(String token) async {
    try {
      final request = await datasource.fetchAllBrands(token);
      final response = request.map(ExpressCategory.fromStorage).toList();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
