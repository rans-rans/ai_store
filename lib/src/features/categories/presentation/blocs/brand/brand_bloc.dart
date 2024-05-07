import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/brand.dart';
import '../../../domain/repositories/category_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final CategoryRepository categoryRepository;
  BrandBloc({required this.categoryRepository}) : super(BrandInitial()) {
    on<FetchAllBrandsEvent>((event, emit) async {
      emit(BrandsFetchLoading());
      try {
        final response = await categoryRepository.fetchAllBrands(event.token);
        emit(BrandsFetchSuccess(brands: response));
      } catch (e) {
        emit(BrandsFetchFailed());
      }
    });
  }
}
