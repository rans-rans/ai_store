import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc(this.categoryRepository) : super(CategoriesInitial()) {
    on<FetchAllCategories>((event, emit) async {
      try {
        emit(CategoriesFetchLoading());
        final response = await categoryRepository.fetchAllCategories(event.token);
        emit(CategoriesFetchSuccess(categories: response));
      } catch (e) {
        emit(CategoriesFetchFailed());
      }
    });
  }
}
